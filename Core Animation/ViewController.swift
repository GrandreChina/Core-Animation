//
//  ViewController.swift
//  Core Animation
//
//  Created by Grandre on 16/1/8.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBAction func rotation(sender: UIButton) {
        let ballView = UIView(frame: CGRectMake(20,60,100,100))
        ballView.backgroundColor = UIColor.redColor()
        
        //        ballView.layer.cornerRadius = 50
        self.view.addSubview(ballView)
        
        let rotation = JNWSpringAnimation(keyPath: "transform.rotation")
        rotation.damping = 5  ////        动画阻尼，越大，动画效果越不明显
        rotation.stiffness = 200  ////        动画伸展系数 越大越好伸展
        rotation.mass = 2  ////        动画的质量，帧数正比
        
        rotation.fromValue = 0
        rotation.toValue = M_PI_2/4
        ballView.layer.addAnimation(rotation, forKey: rotation.keyPath)
////        下面一句一定要加上
        ballView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2/4))

        
        let scale = JNWSpringAnimation(keyPath: "transform.scale")
        scale.damping = 6//6
        scale.stiffness = 500//100
        scale.mass = 2//2
        scale.fromValue = 0
        scale.toValue = 1.1
        ballView.layer.addAnimation(scale, forKey: scale.keyPath)
//        下面一句一定要加上
        ballView.transform = CGAffineTransformMakeScale(2,2)
        
        let translation = JNWSpringAnimation(keyPath: "transform.translation.x")
        translation.damping = 6//6
        translation.stiffness = 500//100
        translation.mass = 2//2
        translation.fromValue = 0
        translation.toValue = 400
        ballView.layer.addAnimation(translation, forKey: translation.keyPath)
        //        下面一句一定要加上
        ballView.transform = CGAffineTransformMakeTranslation(400, 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let ballView = UIView(frame: CGRectMake(20,60,100,100))
//        ballView.backgroundColor = UIColor.redColor()
////        ballView.layer.cornerRadius = 50
//        self.view.addSubview(ballView)
   
//    原生普通动画
//        UIView.animateWithDuration(3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            ballView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(2, 2), CGAffineTransformMakeTranslation(100, 60))
//            
//            ballView.backgroundColor = UIColor.greenColor()
//            }, completion: nil)
        
////        原生弹性动画
//        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity:10 , options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
////     组合动画
//            ballView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(2, 2), CGAffineTransformMakeTranslation(400, 60))
//            
//            ballView.backgroundColor = UIColor.greenColor()
//            
//            }, completion: nil)
        
        let ballView = UIView(frame: CGRectMake(20,60,100,100))
        ballView.backgroundColor = UIColor.redColor()
        
        //        ballView.layer.cornerRadius = 50
        self.view.addSubview(ballView)
        
        let rotation = JNWSpringAnimation(keyPath: "transform.rotation")
        rotation.damping = 5  ////        动画阻尼，越大，动画效果越不明显
        rotation.stiffness = 200  ////        动画伸展系数 越大越好伸展
        rotation.mass = 2  ////        动画的质量，帧数正比
        
        rotation.fromValue = 0
        rotation.toValue = M_PI_2/4
        ballView.layer.addAnimation(rotation, forKey: rotation.keyPath)
        ////        下面一句一定要加上
        ballView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2/4))
        
        
        let scale = JNWSpringAnimation(keyPath: "transform.scale")
        scale.damping = 6//6
        scale.stiffness = 500//100
        scale.mass = 2//2
        scale.fromValue = 0
        scale.toValue = 1.1
        ballView.layer.addAnimation(scale, forKey: scale.keyPath)
        //        下面一句一定要加上
        ballView.transform = CGAffineTransformMakeScale(2,2)
        
        let translation = JNWSpringAnimation(keyPath: "transform.translation.x")
        translation.damping = 6//6
        translation.stiffness = 500//100
        translation.mass = 2//2
        translation.fromValue = 0
        translation.toValue = 400
        ballView.layer.addAnimation(translation, forKey: translation.keyPath)
        //        下面一句一定要加上
        ballView.transform = CGAffineTransformMakeTranslation(400, 0)
        ballView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(2,2), CGAffineTransformMakeRotation(CGFloat(M_PI_2/4)))
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

