//
//  DiscoveryPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/21/24.
//

import SwiftUI

struct DiscoveryPage: View {
    
    @Binding var hideTabBar: Bool
    
    var body: some View {
            NavigationStack{
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
                                Button(action: {
                                    print("Search")
                                }) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                }
                                NavigationLink(destination: FilterView()) {
                                    Image(systemName: "gearshape")
                                        .font(.title)
                                        .foregroundColor(Color.white)
                                        .padding(.trailing)

                                }
                            }
                            .padding(.top, 70)
                        )
                    // Main content area
                    Rectangle()
                        .fill(Color("myBeige"))
                        .cornerRadius(50)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.bottom)
                        .padding(.top, 10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .overlay(
                            VStack {
                                NavigationLink(destination: DetailPage(hideTabBar: $hideTabBar)) {
                                    ZStack(alignment: .center) {
                                        Rectangle()
                                            .fill(Color.white)
                                            .cornerRadius(20)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .padding(.horizontal, 15)
                                            .padding(.top, 10)
                                            .padding(40)
                                        
                                        VStack {
                                            ZStack(alignment: .topLeading) {
                                                Image("Fiji_1")
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .frame(maxWidth: 265, maxHeight: .infinity)
                                                    .padding(.top, 65)
                                                
                                                VStack {
                                                    Text("Fiji, South Pacific Islands")
                                                        .foregroundColor(.white)
                                                        .bold()
                                                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                                                        .padding(.top, 60)
                                                        .padding(.leading)
                                                }
                                                .padding(.top, 10)
                                            }
                                            Text("Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands, with about 110 inhabited. Known for its pristine beaches, turquoise waters, and...")
                                                .frame(maxWidth: .infinity, maxHeight: 200)
                                                .padding(.horizontal, 75)
                                                .padding(.top, -40)
                                                .padding(.bottom, 25)
                                                .foregroundColor(.black)
                                                .font(.system(size: 15))
                                        }
                                        Spacer()
                                        
                                            
                                        
                                    }
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
                .ignoresSafeArea(edges: .top)
               
 
            }

        } // end of var body
}

#Preview {
    DiscoveryPage(hideTabBar: .constant(false))
}
