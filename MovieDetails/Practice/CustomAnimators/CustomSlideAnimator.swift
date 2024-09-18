//
//  CustomSlideAnimator.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation
import UIKit

class CustomSlideAnimator: NSObject {
    let duration: TimeInterval
    let viewControllers: [UIViewController]

    init(duration: TimeInterval, viewControllers: [UIViewController]) {
        self.duration = duration
        self.viewControllers = viewControllers
    }
}

extension CustomSlideAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromIndex = indexForVC(target: fromVC)
        let toVC = transitionContext.viewController(forKey: .to)
        let toIndex = indexForVC(target: toVC)
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        guard let fromIndex,
              let toIndex,
              let fromView,
              let toView
        else { return }

        let absDx = fromView.frame.width
        let toDx = toIndex > fromIndex ? absDx : -absDx
        let fromDx = -toDx
        toView.transform = CGAffineTransform(translationX: toDx, y: 0)

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)

        UIView.animate(withDuration: duration) {
            toView.transform = .identity
            fromView.transform = CGAffineTransform(translationX: fromDx, y: 0)
        } completion: { _ in
            fromView.transform = .identity
            transitionContext.completeTransition(true)
        }
    }

    func indexForVC(target: UIViewController?) -> Int? {
        viewControllers.firstIndex { source in
            source === target
        }
    }
}
