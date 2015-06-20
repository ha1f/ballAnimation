//
//  ViewController.swift
//  ballAnimation
//
//  Created by 山口 智生 on 2015/06/20.
//  Copyright (c) 2015年 NextVanguard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mySubButton: [SubBallButton!] = []
    var mainButton: UIButton!
    var subButtonFlag: Bool = false
    var animatingflag: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //サブボタンを準備
        for i in 0...4 {
            mySubButton.append(SubBallButton())
            mySubButton[i].setDefaultPoint(CGPointMake(self.view.bounds.width/2, self.view.bounds.height/2))
            mySubButton[i].setTargetPoint(self.makePointWithRelativePolar(self.view.bounds.width/2, y: self.view.bounds.height/2, radius: 150, angle: Double(30+30*i)))
            mySubButton[i].setPositionToDefalut()
            mySubButton[i].backgroundColor = UIColor(hue: CGFloat(0.2*Double(i)), saturation: 1.0, brightness: 1.0, alpha: 0.8)
            mySubButton[i].tag = i
        }
        
        //メインボタン
        mainButton = UIButton(frame: CGRectMake(0,0,100,100))
        mainButton.layer.position = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/2)
        mainButton.layer.cornerRadius = 50.0
        mainButton.setTitle("Fire!", forState: .Normal)
        mainButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        mainButton.backgroundColor = UIColor.redColor()
        mainButton.addTarget(self, action: "onButtonDown:", forControlEvents: .TouchDown)
        self.view.addSubview(mainButton)
        
        self.subButtonFlag = false
    }
    
    //メインボタンが押された時
    @IBAction func onButtonDown(sender: AnyObject?){
        if(!self.animatingflag){//アニメーション中は反応しないように
            if subButtonFlag {
                self.animatingflag = true
                self.subButtonFlag = false
                for tmpButton in mySubButton {
                    tmpButton.animateToDefault(0.5, completion: {(Bool) -> Void in
                        self.mainButton.setTitle("Fire!", forState: .Normal)
                        self.animatingflag = false
                    })
                }
            }else{
                self.animatingflag = true
                self.subButtonFlag = true
                
                for tmpButton in mySubButton {
                    //消えてたら復活させる
                    if(!tmpButton.isDescendantOfView(self.view)){
                        self.view.addSubview(tmpButton)
                    }
                    
                    tmpButton.animateToTarget(0.5, completion: {(Bool) -> Void in
                        //self.view.addSubview(self.mySubButton[i])
                        self.mainButton.setTitle("Back", forState: .Normal)
                        self.animatingflag = false
                    })
                }
            }
            self.view.bringSubviewToFront(mainButton)//最前面へ
        }
    }
    
    //相対的な極座標からxy座標に変換
    func makePointWithRelativePolar(x: CGFloat, y: CGFloat, radius: CGFloat, angle: Double) -> CGPoint!{
        //左回りになるようangleを反転させてる
        return CGPointMake(x + radius * CGFloat(cos(-M_PI * angle / 180)), y + radius * CGFloat(sin(-M_PI * angle / 180)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

