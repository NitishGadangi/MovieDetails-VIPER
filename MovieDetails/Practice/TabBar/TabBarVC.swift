//
//  TabBarVC.swift
//  MovieDetails
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation
import UIKit

final class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarVC {
    func setupTabBar() {
        var tabBarItemVCs = [UIViewController]()
        tabBarItemVCs.append(getTabBarItemVC(title: "First", image: UIImage(systemName: "house"), bgColor: .red))
        tabBarItemVCs.append(getTabBarItemVC(title: "Second", image: UIImage(systemName: "house"), bgColor: .blue))
        tabBarItemVCs.append(getTabBarItemVC(title: "Third", image: UIImage(systemName: "house"), bgColor: .green))
        setViewControllers(tabBarItemVCs, animated: true)

        tabBar.barTintColor = .gray
        tabBar.tintColor = .white
        tabBar.backgroundColor = .lightGray
        selectedIndex = 1
        delegate = self
    }

    func getTabBarItemVC(title: String, image: UIImage?, bgColor: UIColor) -> UIViewController {
        let tabBarItemVC = TabBarItemVC(text: title)
        tabBarItemVC.view.backgroundColor = bgColor
        tabBarItemVC.tabBarItem.title = title
        tabBarItemVC.tabBarItem.image = image
        tabBarItemVC.navigationItem.title = "\(title) controller"
        return tabBarItemVC
    }
}

extension TabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return CustomSlideAnimator(duration: 1, viewControllers: viewControllers ?? [])
    }
}
