//
//  CustomDismissAnimator.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 28/07/24.
//

import Foundation
import UIKit

class CustomDismissAnimator: NSObject {
    private let duration: TimeInterval

    init(duration: TimeInterval = 1) {
        self.duration = duration
    }
}

extension CustomDismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView

        let startFrame = fromVC?.view.frame
        let endFrame = toVC?.view.subviews[safe: 0]?.frame
        guard let startFrame, let endFrame else { return }

        let scaleTransform = CGAffineTransform(scaleX: endFrame.width/startFrame.width,
                                              y: endFrame.height/startFrame.height)
        let transitionTransform = CGAffineTransform(translationX: endFrame.midX - startFrame.midX,
                                                    y: endFrame.midY - startFrame.midY)
        guard let toVcView = toVC?.view, let fromVCView = fromVC?.view else { return }

        containerView.addSubview(toVcView)
        containerView.bringSubviewToFront(fromVCView)

        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn]) {
            fromVC?.view.transform = scaleTransform.concatenating(transitionTransform)
        } completion: { didComplete in
            transitionContext.completeTransition(didComplete)
        }
    }
}

