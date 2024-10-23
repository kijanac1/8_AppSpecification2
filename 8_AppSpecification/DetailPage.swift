//
//  DescriptionPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/22/24.
//

import SwiftUI

struct DetailPage: View {
    
    @Binding var hideTabBar: Bool
    @State private var fijiImages = ["Fiji_3", "Fiji_4","Fiji_1", "Fiji_2", ]
    @State private var currentImageIndex = 0  // Track the current image index
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
            
            Text("Fiji, South Pacific Islands")
                .foregroundColor(Color("myGreen"))
                .font(.system(size: 20))
                .padding()
                .padding(.bottom, -18)
            
            GeometryReader { geometry in
                ZStack{
                    Image(fijiImages[currentImageIndex])
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
                                Text("Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands, with about 110 inhabited. Known for its pristine beaches, turquoise waters, and vibrant coral reefs, Fiji is a popular destination for snorkeling, diving, and beach vacations. The islands boast a rich cultural heritage, blending indigenous Fijian traditions with Indian, European, and Chinese influences. Visitors can experience warm hospitality, partake in traditional kava ceremonies, and explore local villages to gain insight into the islanders' way of life. Fiji's lush rainforests, dramatic landscapes, and cascading waterfalls provide endless opportunities for adventure, from hiking to zip-lining. The capital city, Suva, offers a mix of modern amenities and cultural landmarks, such as the Fiji Museum and Thurston Gardens. Whether ")
                                    .padding()
                            }
                            .frame(width: 350, height: 280)
                            .cornerRadius(15)
                        } // ZStack
                        .offset(y: 280)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                print("Plus in a box button tapped")
                            }) {
                                Image(systemName: "plus.square")
                                    .font(.title)
                                    .foregroundColor(Color("myBrown"))
                            }
                            
                            NavigationLink(destination: GuideView()) {
                                Image(systemName: "book")
                                    .font(.title)
                                    .foregroundColor(Color("myBrown"))
                                    .padding(.trailing)
                            }
                        } // HStack for buttons
                        .offset(y: 290)
                    } // VStack
                    
                    Button(action: {
                        // Increment the current image index to show the next image
                        currentImageIndex = (currentImageIndex + 1) % fijiImages.count
                    }) {
                        Image(systemName: "chevron.right")  // Chevron right button
                            .font(.system(size: 40))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding(.leading, 340)
                            .shadow(color: Color.black.opacity(0.9), radius: 5, x: 2, y: 2)
                            .padding()
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
    DetailPage(hideTabBar: .constant(false))
}
