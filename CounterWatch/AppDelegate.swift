//
//  AppDelegate.swift
//  CounterWatch
//
//  Created by Alberto Scampini on 16/03/15.
//  Copyright (c) 2015 Alberto Scampini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.

    }
    
    // MARK: - request from Watchkit
    func application(application: UIApplication!, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]!, reply: (([NSObject : AnyObject]!) -> Void)!) {
        
        //estract data
        let counterValue: NSString? = userInfo["count"] as? NSString
        
        NSNotificationCenter.defaultCenter().postNotificationName("addCountValue", object: counterValue)
        
        // pass back values to Apple Watch
        var retValues = Dictionary<String,String>()
        retValues["message"] = "done"
        reply(retValues)
        
        //connect to data
        var defaults = NSUserDefaults(suiteName: "group.Alberto-Scampini.CounterWatch")
        
        //load data
        var arrayCount:NSMutableArray = defaults?.valueForKey("Counter") as NSMutableArray
        
        //update data
        arrayCount.addObject(counterValue!.integerValue)
        
        //save data
        defaults?.setObject(arrayCount, forKey: "Counter")
        
        defaults?.synchronize()
        
        
    }
}