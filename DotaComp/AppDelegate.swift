//
//  AppDelegate.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-20.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Chameleon
import UserNotifications
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        return true
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.alert)
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let userInfo = notification.userInfo
//        let productName = userInfo![Constants.notificationProductNameKey]!
//        let productDate = userInfo![Constants.notificationProductDateKey]!
//        let msg = "O produto \(productName) ira vencer em \(productDate)"
//        let alert = UIAlertController(title: "Atenção!", message: msg, preferredStyle: UIAlertControllerStyle.alert)
//        let topWindow = UIWindow(frame: UIScreen.main.bounds)
//        topWindow.rootViewController = UIViewController()
//        topWindow.windowLevel = UIWindowLevelAlert + 1
//
//        alert.addAction(UIAlertAction(title: "Ok",
//                                      style: UIAlertActionStyle.default,
//                                      handler: { (_ action: UIAlertAction) -> Void in
//                                        topWindow.isHidden = true
//        }))
//        topWindow.makeKeyAndVisible()
//        topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
    }


}

