//
//  UIApplication+Window.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 01/06/23.
//

import UIKit

extension UIApplication {
    // This is a work around until we drop iOS 14
    // if #available(15.0, *) - adding this so it comes up in searches for that in the future
    var activeWindow: UIWindow? {
        connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first(where: { !($0 is LoadingWindow) })
    }
    var activeScene: UIWindowScene? {
        connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene
    }
    var activeRootViewController: UIViewController? {
        activeScene?.activeWindow?.rootViewController
    }
    
    var activeWindowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first as? UIWindowScene
    }
    
    func topViewController(_ base: UIViewController? = UIApplication.shared.activeRootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            let top = topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                let top = topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController {
            let top = topViewController(presented)
            return top
        }
        return base
    }
}

extension UIWindowScene {
    var activeWindow: UIWindow? {
        if windows.count == 1 {
            // we only have one window and might be launching where nothing is "key and visible" yet
            return windows.first
        } else {
            return windows.first { $0.isKeyWindow }
        }
    }
}
