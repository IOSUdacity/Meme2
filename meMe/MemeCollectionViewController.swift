//
//  MemeCollectionViewController.swift
//  meMe
//
//  Created by Jack McCabe on 12/3/21.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {


    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
        //This gets you a copy of the memes from the appDelegate
        var memes: [Meme]! {
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
        }
    //returns number of memes in the array
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int ) -> Int {
        return self.memes.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        
        cell.topLabel =  meme.topText
        cell.bottomLabel = meme.bottomText
        cell.memeImage.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailVC =  self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController!.pushViewController(detailVC, animated: true)       
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
     //   super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - ( 2*space)) / 3.0
        let heightDimension = (view.frame.size.height - (2 * space)) / 3.0

        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height:heightDimension)
        
        
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
