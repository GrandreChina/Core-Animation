//
//  AppDelegate.swift
//  Core Animation
//
//  Created by Grandre on 16/1/8.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
// 在iOS开发中，处理的一个又一个UIView，实际是在操作CALayer。那么为什么不直接对CALayer进行编程呢？那是因为CALayer继承自NSObject，主要是用于图层的处理以及动画，而UIView继承自UIResponder，可以处理交互事件。
        
//  由此，可以认为UIView就是对CALayer的一个简单封装，图像绘制、动画都是CALayer做的。有过开发经验的朋友都知道，苹果在UIView里面封装了一套动画接口，但是利用这些接口，只是可以做一些简单、不灵活的动画。如果想在底层做一些改变，想实现一些特别的动画，这是学会掌控Core Animation以外，别无他选。
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.backgroundColor = UIColor(patternImage: UIImage(named: "swift_logo")!)

        
        self.window?.makeKeyAndVisible()
        
        let vc = UIViewController(nibName: nil, bundle: nil)
//        实例化一个vc之后，还要设置一下他的view。这样，在后面，才能用vc的view来addSubView
//        vc加载的subView们在window加载的subView们下面。所以先看到的是window的subview。
        vc.view = UIView(frame:UIScreen.mainScreen().bounds)
//       window必须先制定一个uiviewcontroller。后面，可以直接用window来addSubview。
        self.window?.rootViewController = vc
//        如果要添加一个新的视图控制器，则需要在vc的基础上presentViewController。
        
        
        let overLayer = UIView(frame: self.window!.bounds)
        overLayer.backgroundColor = UIColor.blackColor()
        overLayer.alpha = 0
        self.window?.addSubview(overLayer)
        
        
        let alertView = UIView(frame: CGRectMake(self.window!.bounds.width/2 - 250 / 2 ,self.window!.bounds.height/2 - 250/2,250,250))
            alertView.backgroundColor = UIColor(patternImage: UIImage(named: "swift_logo")!)
//            alertView.backgroundColor = UIColor.blueColor()
        
            alertView.alpha = 0
            alertView.layer.cornerRadius = 125
            
//        下面一句如果设置为true，则把阴影也去掉了。如果又想阴影，又想填充一个图片，则可通过alertView.backgroundColor =UIColor(patternImage: UIImage(named: "swift_logo")!)方式填充，而非通过设置layer.contents= UIImage(named: "swift_logo")?.CGImage 加载。但layer.contents填充图片方式好处是可以任意调整图片的显示方式。
//            alertView.layer.masksToBounds = true
        
            alertView.transform = CGAffineTransformMakeScale(1.2, 1.2)
//      alertView.layer.transform 是3D
        
            alertView.layer.shadowOffset = CGSizeMake(0, 10)
            alertView.layer.shadowColor = UIColor.greenColor().CGColor
            alertView.layer.shadowOpacity = 1
            alertView.layer.shadowRadius = 10
//  阴影默认是跟随view的边界。view在上面设置成了圆形，现在可以改成方形。
//            let shadowP = CGPathCreateMutable()
//            CGPathAddRect(shadowP, nil,alertView.bounds)
//            alertView.layer.shadowPath = shadowP

//CALayer有一个contents属性，它在OC中是id类型，在Swift中是AnyObject类型，这意味着它可以是任何类型对象。但在实践中，如果给这个属性赋值的不是CGImage类型，图层会是一片空白。它的这个奇怪的现象是因为MAC OS原因造成的，在MAC OS系统上，给它赋值CGImage或者NSImage都是起作用的，但是在iOS系统，如果将UIImage赋值给它，图层只会是一片空白。（注意，视图指的是UIView，图层指的是CALayer）
        /**
        *  相当于UIImageView的contentMode属性，可以设置图片显示样式
        kCAGravityCenter
        kCAGravityTop
        kCAGravityBottom
        kCAGravityLeft
        kCAGravityRight
        kCAGravityTopLeft
        kCAGravityTopRight
        kCAGravityBottomLeft
        kCAGravityBottomRight
        kCAGravityResize
        kCAGravityResizeAspect
        kCAGravityResizeAspectFill
        */
       
        //相当于UIImageView的contentMode属性，可以设置图片显示样式
//            alertView.layer.contents = UIImage(named: "swift_logo")?.CGImage
//            alertView.layer.contentsGravity = kCAGravityResizeAspectFill
        
        //contentsScale定义了CGImage的像素尺寸和视图大小比例，默认情况下为1.0
        //如何理解这句话，我是这么理解的，屏幕有非retina屏幕(像素和尺寸是1：1)
        //还有retina屏幕，像素和尺寸比是2：1
        //现在还出现了@3x图片，像素和尺寸比理论上是3：1，但实际上在显示的时候，苹果进行了调整（具体可以看ios9的新特性）
        //那么，像我下面这么写，就是说像素点按照屏幕来调整，如果是非retaina，那么就是1：1，如果是retina，就是2：1
//            alertView.layer.contentsScale = UIScreen.mainScreen().scale
        
//        
        
//            vc.view.addSubview(alertView)
        self.window?.addSubview(alertView)
//        self.window?.bringSubviewToFront(overLayer)
        
        var minSeconds = 0 * Double(NSEC_PER_SEC)  //0指等待0秒播放动画
        var dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minSeconds))
        dispatch_after(dtime, dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                overLayer.alpha = 0.3
                alertView.alpha = 1
                }, completion: nil)
    
    
            let scale = JNWSpringAnimation(keyPath: "transform.scale")
            scale.damping = 14
            scale.stiffness = 14
            scale.mass = 1//2
            scale.fromValue = 3
            scale.toValue = 1
            alertView.layer.addAnimation(scale, forKey: scale.keyPath)
            //        下面一句一定要加上
            alertView.transform = CGAffineTransformMakeScale(1,1)
        }
        
        minSeconds = 3 * Double(NSEC_PER_SEC)
         dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minSeconds))
        dispatch_after(dtime, dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                overLayer.alpha = 0
                alertView.alpha = 0
                }, completion: nil)
            
            
            let scale = JNWSpringAnimation(keyPath: "transform.scale")
            scale.damping = 14
            scale.stiffness = 14
            scale.mass = 2//2
            scale.fromValue = 1
            scale.toValue = 0.3
            alertView.layer.addAnimation(scale, forKey: scale.keyPath)
            //        下面一句一定要加上
            alertView.transform = CGAffineTransformMakeScale(0.3,0.3)
            
            let translate = JNWSpringAnimation(keyPath: "transform.translation.y")
            translate.damping = 14
            translate.stiffness = 14
            translate.mass = 1//2
            translate.fromValue = UIScreen.mainScreen().bounds.size.height/2 - 250/2
            translate.toValue = UIScreen.mainScreen().bounds.size.height
            alertView.layer.addAnimation(translate, forKey: translate.keyPath)
            //        下面一句一定要加上
//            alertView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.size.height)
        }
//        
//        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            overLayer.alpha = 0.3
//            alertView.alpha = 1
//            }, completion: nil)
//        
//        
//        let scale = JNWSpringAnimation(keyPath: "transform.scale")
//        scale.damping = 14
//        scale.stiffness = 440
//        scale.mass = 1//2
//        scale.fromValue = 1.2
//        scale.toValue = 1
//        alertView.layer.addAnimation(scale, forKey: scale.keyPath)
//        //        下面一句一定要加上
//        alertView.transform = CGAffineTransformMakeScale(1,1)
        
        
//        UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            overLayer.alpha = 0.3
//            alertView.alpha = 0
//            }, completion: nil)
//        
//        
//        let scaleToDisplay = JNWSpringAnimation(keyPath: "transform.scale")
//        scaleToDisplay.damping = 14
//        scaleToDisplay.stiffness = 14
//        scaleToDisplay.mass = 1//2
//        scaleToDisplay.fromValue = 1
//        scaleToDisplay.toValue = 0.7
//        alertView.layer.addAnimation(scaleToDisplay, forKey: scaleToDisplay.keyPath)
//        //        下面一句一定要加上
//        alertView.transform = CGAffineTransformMakeScale(0.7,0.7)
        let alert1 = UIAlertController(title: "grandre2", message: "grandre2", preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "点我", style: UIAlertActionStyle.Destructive) { (_) -> Void in
            print("grandre111")
            
        }
        alert1.addAction(alertAction)
        vc.presentViewController(alert1, animated: true, completion: nil)
        
//        let alert = UIAlertController(title: "grandre", message: "grandre", preferredStyle: UIAlertControllerStyle.Alert)
//        vc.presentViewController(alert, animated: true, completion: nil)
       
        minSeconds = 5 * Double(NSEC_PER_SEC)
        dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minSeconds))
        dispatch_after(dtime, dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                alert1.view.alpha = 0.3
                }, completion: { (ifFinish) -> Void in
                    alert1.dismissViewControllerAnimated(ifFinish, completion: nil)
            })
            
            let scale = JNWSpringAnimation(keyPath: "transform.scale")
            scale.damping = 14
            scale.stiffness = 14
            scale.mass = 2//2
            scale.fromValue = 1
            scale.toValue = 0.3
            alert1.view.layer.addAnimation(scale, forKey: scale.keyPath)
            //        下面一句一定要加上
            alert1.view.transform = CGAffineTransformMakeScale(0.3,0.3)

        }
      
        
//        CGAffineTransformIdentity   layer原始数据
//            alert1.view.layer.presentationLayer()?.valueForKeyPath(scale.keyPath)?.floatValue    当前表现层的scale值
        
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
    }


}

