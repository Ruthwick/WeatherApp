//
//  LoadingIndicator.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation
import SwiftUI

class LoadingIndicator {

    static let shared = LoadingIndicator()
    
    private var window: LoadingWindow?
    
    lazy private var rootVC: UIViewController = {
        let loadingView = LoadingView()
        let hostingVC = LoadingHostingController(rootView: loadingView)
        hostingVC.view.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        return hostingVC
    }()
    
    func setupLoadingWindowIfNeeded() {
        guard window == nil else { return }
        guard let scene = UIApplication.shared.activeScene else { return }
        let window = LoadingWindow(windowScene: scene)
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
        window.isHidden = true
    }
    
    func show() {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.show()
            }
            return
        }

        window?.isHidden = false
    }

    func hide() {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.hide()
            }
            return
        }

        window?.isHidden = true
    }
}
