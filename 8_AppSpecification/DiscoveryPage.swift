//
//  DiscoveryPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/21/24.
//

import SwiftUI

struct DiscoveryPage: View {
    
    @State private var locationImages = [["Fiji_1", "Fiji_2","Fiji_3", "Fiji_4" ],["kyoto_1", "kyoto_2", "kyoto_3"]]
    @State private var locationName = ["Fiji, South Pacific Islands", "Kyoto, Japan"]
    @State private var currentIndex = 0
        
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
                        .frame(width: 350, height: 600)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .overlay(
                            VStack {
                                NavigationLink(destination: DetailPage(
                                    images: locationImages[currentIndex],
                                    locationName: locationName[currentIndex],
                                    description: description[currentIndex]
                                )
                            ) {
                                    ZStack(alignment: .center) {
                                        Rectangle()
                                            .fill(Color.white)
                                            .cornerRadius(20)
                                            .frame(width: 300, height: 440)
                                            .padding(.horizontal, 15)
                                            .padding(.top, 50)
                                            .padding(40)
                                        
                                        VStack {
                                            ZStack(alignment: .topLeading) {
                                                Image(locationImages[currentIndex][0])
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .frame(width: 275, height: 285)
                                                VStack {
                                                    Text(locationName[currentIndex])
                                                        .foregroundColor(.white)
                                                        .bold()
                                                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                                                        .padding(.leading)
                                                }
                                                .padding(.top, 10)
                                            }
                                            .padding(.top, -75)
                                            Text(description[currentIndex])
                                                .frame(width: 255, height: 115)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 15))
                                        }
                                        .padding(.top, 120)
                                        Spacer()
                                        
                                            
                                        
                                    }
                                }
                                
                                Button(action: {
                                    chooseRandomIndex()
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color("myBrown"))
                                            .cornerRadius(10)
                                            .frame(width: 275, height: 40)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .ignoresSafeArea(edges: .top)
               
 
            }

        } // end of var body
    
    func chooseRandomIndex() {
        currentIndex = (currentIndex + 1) % locationImages.count
    }
    
    @State private var description = [
        "Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands, with about 110 inhabited. Known for its pristine beaches, turquoise waters, and vibrant coral reefs, Fiji is a popular destination for snorkeling, diving, and beach vacations. The islands boast a rich cultural heritage, blending indigenous Fijian traditions with Indian, European, and Chinese influences. Visitors can experience warm hospitality, partake in traditional kava ceremonies, and explore local villages to gain insight into the islanders' way of life. Fiji's lush rainforests, dramatic landscapes, and cascading waterfalls provide endless opportunities for adventure, from hiking to zip-lining. The capital city, Suva, offers a mix of modern amenities and cultural landmarks, such as the Fiji Museum and Thurston Gardens. ",
        
        "Kyoto, Japan, is a city steeped in history and tradition, serving as the cultural heart of Japan for over a thousand years. Once the imperial capital, Kyoto is renowned for its beautifully preserved temples, shrines, and traditional wooden houses. The city is home to over 1,600 Buddhist temples and 400 Shinto shrines, including iconic landmarks like Kinkaku-ji (the Golden Pavilion), Fushimi Inari-taisha, and Kiyomizu-dera. Visitors can explore serene Zen gardens, tea houses, and ancient palaces that offer a glimpse into Japan's rich spiritual and cultural heritage.Kyoto is also famous for its seasonal beauty, with cherry blossoms in the spring and vibrant autumn leaves attracting travelers from around the world."
    
    ]
}

#Preview {
    DiscoveryPage()
}
