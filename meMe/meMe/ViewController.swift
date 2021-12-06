//
//  ViewController.swift
//  meMe
//
//  Created by Jack McCabe on 11/18/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var midScreenImage: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!

    
    @IBOutlet weak var shareMemeBarButton: UIBarButtonItem!
    
  

    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareMemeBarButton.isEnabled = false
        setTextStyle(topTextField, "TOP")
        setTextStyle(bottomTextField, "BOTTOM")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor:UIColor.black,
        NSAttributedString.Key.foregroundColor:UIColor.white,
        NSAttributedString.Key.backgroundColor:UIColor.clear,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: NSNumber(value: -3.0 as Float) ]
    
    
    func setTextStyle(_ textField: UITextField, _ type: String){
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.text = type
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField){
        if(textField.text == "TOP" || textField.text == "BOTTOM"){
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector:   #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self)
        /*
         Removing to one line of code but keeping in for future reference to remove one notification
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
         */
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification)->CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func pickImage(source: UIImagePickerController.SourceType){
        var pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = source
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func settingImage(_ sender: Any) {
        pickImage(source: .photoLibrary)
    }
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(source: .camera)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            midScreenImage.image = selectedImage
            shareMemeBarButton.isEnabled = true
        }
        
        if let imURL = info[UIImagePickerController.InfoKey.imageURL]{
            print("\(imURL)")
        }
        
        dismiss(animated: true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion:nil)
    }
    
    
    func generatedMemedImage() ->UIImage {
        
        toolBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates:true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        
        return memedImage
    }
    
    @IBAction func shareMemeviaBarButton(_ sender: Any) {
        
        let memeImage = generatedMemedImage()
        let savedMeme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: midScreenImage.image!, memedImage: memeImage)
        
        let UIViewCont = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)

        UIViewCont.completionWithItemsHandler = {activity, success, items, error in
            if success {
            self.save(memeImage)
            }
        }
        
        UIViewCont.popoverPresentationController?.sourceView = self.view
        //Playing with this functionality
        UIViewCont.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        
        present(UIViewCont, animated: true, completion: nil)
    }
 
    
    func save(_ memedImage: UIImage) {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: midScreenImage.image!, memedImage: memedImage)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.memes.append(meme)
    }
    
    
    
}
