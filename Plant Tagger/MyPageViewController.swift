//
//  MyPageViewController.swift
//  Plant Tagger
//
//  Created by Chun Yap on 13/11/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    var user : UserService.User!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if( user == nil )
        {
            let userServ = UserService()
            userServ.getProfile(onSuccessCallback: { user in
                self.user = user
            })
        }
        self.nameLabel.text = self.user?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutRequested(_ sender: Any) {
        let authServ = AuthenticationService()
        authServ.logout()
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
        
    }
}
