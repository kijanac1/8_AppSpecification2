//
//  DescriptionPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/22/24.
//

import SwiftUI

struct DetailPage: View {
    
    @State var images: [String]  // List of images
    @State var locationName: String  // Location name
    @State var description: String  // Location description
    @State var currentIndex: Int
    @State private var currentImageIndex = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
            
            Text(locationName)
                .foregroundColor(Color("myGreen"))
                .font(.system(size: 20))
                .padding()
                .padding(.bottom, -18)
            
            GeometryReader { geometry in
                ZStack{
                    Image(images[currentImageIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:  UIScreen.main.bounds.width+2, height: 300)
                        .clipped()
                    
                    VStack {
                        ZStack {
                            // Stationary rectangle as the background
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(15)
                                .frame(width: 370, height: 310)  // Adjust the size as needed
                                .shadow(radius: 5)
                            
                            // Scrollable text inside the rectangle
                            ScrollView {
                                Text("Description")
                                    .padding(.bottom, -10)
                                    .foregroundColor(Color("myTeal"))
                                    .bold()
                                Text(description)
                                    .padding()
                            }
                            .frame(width: 350, height: 280)
                            .cornerRadius(15)
                        } // ZStack
                        .offset(y: 280)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                // Show the alert when the button is pressed
                                showAlert = true
                            }) {
                                Image(systemName: "plus.square")
                                    .font(.title)
                                    .foregroundColor(Color("myBrown"))
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Successfully added to your bucket list"),
                                    dismissButton: .default(Text("Continue"))
                                )
                            }
                            
                            NavigationLink(
                                destination: GuideView(
                                    locationName: locationName,
                                    currentIndex: currentIndex
                            )) {
                                Image(systemName: "book")
                                    .font(.title)
                                    .foregroundColor(Color("myBrown"))
                                    .padding(.trailing)
                            }
                        } // HStack for buttons
                        .offset(y: 290)
                    } // VStack
                    
                    HStack{
                        Button(action: {
                            currentImageIndex = (currentImageIndex - 1 + images.count) % images.count
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 40))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.9), radius: 5, x: 2, y: 2)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Increment the current image index to show the next image
                            currentImageIndex = (currentImageIndex + 1) % images.count
                        }) {
                            Image(systemName: "chevron.right")  // Chevron right button
                                .font(.system(size: 40))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.9), radius: 5, x: 2, y: 2)
                                .padding()
                        }
                        
                    }
                    
                }
            }
            .frame(height: 300)
            .padding(.bottom, 375)
            
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    DetailPage(images: ["Fiji_1", "Fiji_2"], locationName: "Fiji, South Pacific Islands", description: "Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands...", currentIndex: 0)
}
