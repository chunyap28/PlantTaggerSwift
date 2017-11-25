//
//  AppDelegate.swift
//  Plant Tagger
//
//  Created by Chun Yap on 27/5/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//

import UIKit
import FacebookCore
import Google
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        self._checkIsLoggedIn()
        return true
    }
    /*
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open:url, sourceApplication:sourceApplication, annotation:annotation)
    }*/
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if(url.scheme!.isEqual("fbXXXXXXXXXXX")) {
            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
            
        } else {
            return GIDSignIn.sharedInstance().handle(url as URL!,
                                                     sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                                     annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            //let userId = user.userID                  // For client-side use only!
            //let idToken = user.authentication.idToken // Safe to send to the server
            //let fullName = user.profile.name
            //let givenName = user.profile.givenName
            //let familyName = user.profile.familyName
            //let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            //let userId = user.userID                  // For client-side use only!
            //let idToken = user.authentication.idToken // Safe to send to the server
            //let fullName = user.profile.name
            //let givenName = user.profile.givenName
            //let familyName = user.profile.familyName
            //let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    private func _checkIsLoggedIn()
    {
        let userServ = UserService()
        userServ.getProfile(onSuccessCallback: { user in
            self._moveToLoggedInPage(user: user)
        })
    }
    
    private func _moveToLoggedInPage(user: UserService.User)
    {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ptTabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ptTabBarController") as! UITabBarController
        
        let controller = ptTabBar.viewControllers![0] as! MyPageViewController
        //let ptTabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyPageController") as! MyPageViewController
        controller.user = user
        self.window?.rootViewController = ptTabBar
    }
}

