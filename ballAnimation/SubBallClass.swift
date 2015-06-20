//
//  SubBallClass.swift
//  ballAnimation
//
//  Created by 山口 智生 on 2015/06/20.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import Foundation
import UIKit

//UIButtonを継承したクラス
class SubBallButton: UIButton {
    //targetとdefaultを持たせておく
    private var targetPoint: CGPoint!
    private var defaultPoint: CGPoint!
    
    init(){
        //標準のプロパティを与えておく
        super.init(frame: CGRectMake(0,0, 80,80))
        self.layer.cornerRadius = 40
        self.addTarget(self, action: "onUpInside:", forControlEvents: .TouchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //タップすると消える
    func onUpInside(sender: AnyObject?){
        println("upInside")
        self.destroy()
    }
    
    //ビューから削除
    func destroy(){
        self.removeFromSuperview()
    }
    
    //プロパティのget
    func getTargetPoint() -> CGPoint!{
        return self.targetPoint
    }
    
    func getDefaultPoint() -> CGPoint!{
        return self.defaultPoint
    }
    
    //プロパティのset
    func setDefaultPoint(point: CGPoint!){
        self.defaultPoint = point
    }
    
    func setTargetPoint(point: CGPoint!){
        self.targetPoint = point
    }
    
    //実際の座標をセット
    func setPositionToTarget(){
        self.layer.position = self.targetPoint
    }
    
    func setPositionToDefalut(){
        self.layer.position = self.defaultPoint
    }

    /*アニメーション*/
    
    //targetまで移動
    func animateToTarget(duration: NSTimeInterval, completion: (Bool)-> Void){//targetまで
        animateToPoint(duration, point: self.targetPoint, completion: completion)
    }
    
    //defaultまで移動
    func animateToDefault(duration: NSTimeInterval, completion: (Bool)-> Void){//defaultまで
        animateToPoint(duration, point: self.defaultPoint, completion: completion)
    }
    
    //引数でセットしたpositionまで移動
    func animateToPoint(duration: NSTimeInterval, point: CGPoint, completion: (Bool)-> Void){//指定pointまで
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {() -> Void in
            self.layer.position = point}, completion:completion)
    }
}
