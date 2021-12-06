//
//  AppDelegate.swift
//  meMe
//
//  Created by Jack McCabe on 11/18/21.
//

import UIKit

struct Meme{
    var topText:String
    var bottomText:String
    var originalImage:UIImage? //removed ? UIImage?
    var memedImage:UIImage
}

    //var image1 = UIImage(named:"Images.xcassets/Zorin")
//var firstMeme:Meme = Meme(topText : "Whats Up", bottomText: "Whats Down", originalImage: image1! , memedImage:  image1! )


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //var imageView:UIImageView = UIImageView(frame:CGRect(x:10, y:50, width:100, height:300))
    
        // imageView.image = UIImage(named: "green-square-Retina")
    
    
    //data
    
   
    var memes = [Meme]()
  // memes.append(firstMeme)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


