//
//  LoadingWindow.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import UIKit

class LoadingWindow: UIWindow {

    override var description: String {
        "<LoadingWindow>"
    }
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        
        var frame = UIScreen.main.bounds
        frame.origin.y = 0
        self.frame = frame
        self.windowLevel = UIWindow.Level.statusBar - 1
        self.isHidden = true
        self.backgroundColor = .clear
        self.isOpaque = false
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
