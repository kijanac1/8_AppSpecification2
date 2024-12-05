//
//  SplashScreenView.swift
//  8_AppSpecification
//
//  Created by Kayla Goldsmith on 10/24/24.
//
import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                Image("WanderLogSplashScreen") // Change to your image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500) // Adjust size as needed
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
            .padding()
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
#Preview{
    SplashScreenView()
}
