//
//  DetailViewController.swift
//  meMe
//
//  Created by Jack McCabe on 12/4/21.
//

import UIKit

class DetailViewController: UIViewController {

    var meme: Meme!
    @IBOutlet weak var memeImaged: UIImageView!
    
    @IBAction func BackSegueButton(_ sender: Any) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImaged = UIImageView(image: meme.memedImage)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
