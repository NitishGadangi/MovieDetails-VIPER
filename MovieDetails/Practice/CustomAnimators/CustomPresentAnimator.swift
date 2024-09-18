//
//  CustomPresentAnimator.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 28/07/24.
//

import Foundation
import UIKit

class CustomPresentAnimator: NSObject {
    private let duration: TimeInterval

    init(duration: TimeInterval = 1) {
        self.duration = duration
    }
}

extension CustomPresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView

        let startFrame = fromVC?.view.subviews[safe: 0]?.frame
        let endFrame = toVC?.view.frame
        guard let startFrame, let endFrame else { return }
        
        let scaleTransform = CGAffineTransform(scaleX: startFrame.width/endFrame.width,
                                              y: startFrame.height/endFrame.height)
        let transitionTransform = CGAffineTransform(translationX: startFrame.midX - endFrame.midX,
                                                    y: startFrame.midY - endFrame.midY)
        toVC?.view.transform = scaleTransform.concatenating(transitionTransform)
        guard let toVcView = toVC?.view else { return }

        containerView.addSubview(toVcView)
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn]) {
            toVC?.view.transform = .identity
        } completion: { didComplete in
            transitionContext.completeTransition(didComplete)
        }
    }
}
