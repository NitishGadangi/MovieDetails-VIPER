//
//  CustomFadeAnimator.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation
import UIKit

final class CustomFadeAnimator: NSObject {
    private let duration: TimeInterval

    init(duration: TimeInterval) {
        self.duration = duration
    }
}

extension CustomFadeAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let containerView = transitionContext.containerView
        guard let fromView, let toView 
        else {
            transitionContext.completeTransition(false)
            return
        }

        toView.alpha = 0
        containerView.addSubview(toView)

        UIView.animate(withDuration: duration) {
            fromView.alpha = 0
            toView.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}
