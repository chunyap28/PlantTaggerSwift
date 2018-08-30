//
//  MyPageViewController.swift
//  Plant Tagger
//
//  Created by Chun Yap on 13/11/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MyPageViewController: UIViewController {

    var user : UserService.User!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _loadProfile()
        _loadProfileImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutRequested(_ sender: Any) {
        let authServ = AuthenticationService()
        authServ.logout()
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        _moveToLoginInPage()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func _loadProfileImage()
    {
        DispatchQueue.global().async {
            let userServ = UserService()
            userServ.getProfileImage(onSuccessCallback: { image in
                DispatchQueue.main.async(execute: {
                    self.profileImage.image = image
                })
            })
        }
    }

    private func _moveToLoginInPage()
    {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ptTabBar = self.storyboard?.instantiateViewController(withIdentifier: "ptSignInController") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = ptTabBar
    }
    
    private func _loadProfile()
    {
        if( user == nil )
        {
            let userServ = UserService()
            userServ.getProfile(onSuccessCallback: { user in
                self.user = user
                self.nameLabel.text = self.user?.name
            })
        }
        else{
            self.nameLabel.text = self.user?.name
        }
    }
}
