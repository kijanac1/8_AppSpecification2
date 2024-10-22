//
//  DiscoveryPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/21/24.
//

import SwiftUI

struct DiscoveryPage: View {
    
    var body: some View {
            VStack {
                // Top color strip with "Discovery Page" text
                Rectangle()
                    .fill(Color("myTeal"))
                    .frame(height: 125)
                    .overlay(
                        HStack{
                            Text("DISCOVERY PAGE")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                .padding(.leading)
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.leading)
                            Image(systemName: "gearshape")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.trailing)
                        }
                        .padding(.top, 70)
                    )
                    .ignoresSafeArea(edges: .top)
                
                // Main content area
                Rectangle()
                    .fill(Color("myBeige"))
                    .cornerRadius(50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                    .padding(.top, -40)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .overlay(
                        VStack{
                            ZStack(alignment: .center){
                                Rectangle()
                                    .fill(Color.white)
                                    .cornerRadius(15)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(.horizontal, 15)
                                    .padding(.top, -40)
                                    .padding(40)
                                Rectangle()
                                    .fill(Color.black)
                                    .cornerRadius(15)
                                    .frame(maxWidth: 265, maxHeight: 265)
                      
                                    .padding(.top, -165)
                            }
                            
                            Button(action: {
                                print("Button tapped!")
                            }) {
                                ZStack {
                                        Rectangle()
                                            .fill(Color("myBrown"))
                                            .cornerRadius(10)
                                            .frame(maxWidth: 275, maxHeight: 40)
                                        Text("Next Destination")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                            }
                            .padding(.bottom, 95)
                        }
                    )
                
                Spacer()
            }
            .background(Color.white)
        }
}

#Preview {
    DiscoveryPage()
}
