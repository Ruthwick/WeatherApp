//
//  LoadingView.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//


import SwiftUI

struct LoadingView: View {
        
    var body: some View {
        ZStack {
            Color(Color.RGBColorSpace.sRGB, white: 0, opacity: 0.8)
                .frame(width: 64, height: 64, alignment: .center)
                .cornerRadius(12)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(2)
        }

    }
}
