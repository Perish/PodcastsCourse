//
//  AppDelegate.swift
//  PodcastsCourse
//
//  Created by 徐冲 on 2018/8/13.
//  Copyright © 2018年 徐冲. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 在iOS App中，UIWindow是最顶层的界面内容，我们使用UIWindow和UIView来呈现界面。
        // UIWindow并不包含任何默认的内容，但是它被当作UIView的容器，用于放置应用中所有的UIView。
        // UIWindow继承自UIView，所以UIWindow除了具有UIView的所有功能之外，还增加了一些特有的属性和方法，
        // 而我们最常用的方法，就是在App刚启动时，
        // 调用UIWindow的rootViewController（必须指定根控制器） 和 makeKeyAndVisible方法
        // UIWindow的主要作用有：
        // 1.作为UIView的最顶层容器，包含应用显示所有的UIView；
        // 2.传递触摸消息和键盘事件给UIView
        window = UIWindow()
        // 让当前UIWindow变成keyWindow（主窗口），并显示出来
        window?.makeKeyAndVisible()
        // 窗口的根视图控制器。
        window?.rootViewController = MainTabBarController()
        
        return true
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


}

