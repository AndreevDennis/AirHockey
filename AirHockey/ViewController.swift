//
//  ViewController.swift
//  AirHockey
//
//  Created by Denis Andreev on 5/6/19.
//  Copyright © 2019 353. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bottomHallf: UIView!
    @IBOutlet weak var topHalf: UIView!
    @IBOutlet weak var centralLine: UIView!
    @IBOutlet weak var bottomGoal: UIView!
    @IBOutlet weak var bottomPaddle: UIView!
    @IBOutlet weak var puck: UIView!
    @IBOutlet weak var topGoal: UIView!
    @IBOutlet weak var topPaddle: UIView!
    
    var topSnapBehaviour : UISnapBehavior?
    var bottomSnapBehaviour : UISnapBehavior?
    var timer  : Timer!
    var animator : UIDynamicAnimator!
    
    
    override func viewDidLoad() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let colision = UICollisionBehavior(items: [puck,topPaddle,bottomPaddle])
        let colisionLine = UICollisionBehavior(items: [topPaddle,bottomPaddle])
        
        colisionLine.addBoundary(withIdentifier: "centralLine" as NSCopying, from: CGPoint(x: 0, y: self.view.center.y), to: CGPoint(x: self.view.frame.width, y: self.view.center.y))
        colisionLine.translatesReferenceBoundsIntoBoundary = true
        colision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(colision)
        animator.addBehavior(colisionLine)
        self.view.bringSubviewToFront(puck)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(statucPuck), userInfo: nil, repeats: true)
    }
    
    @objc func statucPuck(){
        if puck.frame.intersects(bottomGoal.frame){
            print("GoalBottom")
        }
        if puck.frame.intersects(topGoal.frame){
            print("GoalTop")
        }
    }
    
    @IBAction func panGestureTopPaddle(_ sender: UIPanGestureRecognizer) {
        if topSnapBehaviour != nil {
            animator.removeBehavior(topSnapBehaviour!)
        }
        switch sender.state {
        case .began, .changed:
            topSnapBehaviour = UISnapBehavior(item: topPaddle, snapTo: sender.location(in: self.view))
            animator.addBehavior(topSnapBehaviour!)
        default:
            break
        }
        
    }
    
    @IBAction func PanGestureBottomPaddle(_ sender: UIPanGestureRecognizer) {
        if bottomSnapBehaviour != nil {
            animator.removeBehavior(bottomSnapBehaviour!)
        }
        switch sender.state {
        case .began, .changed:
            bottomSnapBehaviour = UISnapBehavior(item: bottomPaddle, snapTo: sender.location(in: self.view))
            animator.addBehavior(bottomSnapBehaviour!)
        default:
              break
            }
        }
    
}

