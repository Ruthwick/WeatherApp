//
//  LoadingHostingController.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import Foundation
import SwiftUI

class LoadingHostingController<Content>: UIHostingController<Content> where Content: View {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
