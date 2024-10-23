//
//  GuideView.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/22/24.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
                .ignoresSafeArea(edges: .top)
            
            ZStack {
                // Stationary rectangle as the background
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                    .frame(width: 370)
                    .frame(maxHeight: .infinity)
                    .shadow(radius: 5)
                
                // Scrollable text inside the rectangle
                ScrollView {
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("Fiji, South Pacific Islands")
                            .foregroundColor(Color("myTeal"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.custom("Roboto-Thin", size: 24))
                            .padding(.top,30)

                        Text("TRAVELER'S GUIDE")
                            .foregroundColor(Color("myTeal"))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Divider()
                            .frame(width: 200, height: 2)  // Set custom width and height
                            .background(Color("myGreen"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        
                        Text("Body Language Tips")
                            .font(.title2)
                            .padding(.bottom, 5)
                        
                        // Do's Section
                        Text("Do’s:")
                            .font(.headline)
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Smile: Fijians are known for their warmth and friendliness, and smiling is considered a sign of respect and hospitality.")
                        }
                        
                        // Don'ts Section
                        Text("Don’ts:")
                            .font(.headline)
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Pointing: Avoid pointing at people with your finger. Instead, use your whole hand to gesture.")
                        }
                        
                        // Common Words & Phrases Section
                        Text("Common Words & Phrases")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Bula!: The universal Fijian greeting, meaning \"Hello!\" and often used with a smile.")
                        }
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Vinaka: Means \"Thank you.\"")
                        }
                        
                        // Electrical Plug & Outlet Info Section
                        Text("Electrical Plug & Outlet Info")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Plug Type: Fiji uses plug types I (three flat pins in a triangular configuration).")
                        }
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Voltage: The standard voltage is 240V, and the frequency is 50Hz.")
                        }
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Adapter Needed?: Travelers from most countries (like the US, UK, and Europe) will need an adapter.")
                        }
                        
                        // Cultural Dos & Don’ts Section
                        Text("Cultural Dos & Don’ts")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        HStack(alignment: .top) {
                            Text("•")
                            Text("Don’t wear hats in villages: In Fijian culture, hats are reserved for chiefs, so wearing one in a village is considered disrespectful.")
                        }
                    }
                    
                }
                .frame(width: 330)
                .frame(maxHeight: .infinity)
                .cornerRadius(15)
            } // ZStack
            .padding(.top, -25)
            .padding(.bottom, 100)
        } // VStack
        .background(Color("myBeige"))
    }
}

#Preview {
    GuideView()
}
