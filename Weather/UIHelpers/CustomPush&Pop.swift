//
//  CustomPush&Pop.swift
//  Weather
//
//  Created by Daniil Kniss on 10.01.2021.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animateTime: TimeInterval = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(rotationAngle: 90)
        
        
        UIView.animateKeyframes(withDuration: animateTime, delay: 0, options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                destination.view.transform = CGAffineTransform(rotationAngle: -90)
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                destination.view.transform = .identity
            }
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }


        
            
    }
        
}
    
    


class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animateTime: TimeInterval = 1.0
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateTime
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        destination.view.transform = CGAffineTransform(rotationAngle: -90)
        
        
        UIView.animateKeyframes(withDuration: animateTime, delay: 0, options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                destination.view.transform = CGAffineTransform(rotationAngle: 90)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                destination.view.transform = .identity
            }
        } completion: { complete in
            transitionContext.completeTransition(complete)
        }
        
         
       
        
    
    }
}
