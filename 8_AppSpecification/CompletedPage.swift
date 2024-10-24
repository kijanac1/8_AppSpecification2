//
//  CompletedPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/23/24.
//

import SwiftUI

struct CompletedPage: View {
    
    @State private var completedTrips = [
        "Portland, OR, USA",
        "San Diego, CA, USA",
        "Las Vegas, NV, USA",
        "New Orleans, LA, USA",
        "Big Bend National Park, USA"
    ]
    
    @State private var isFavoriteToggled = false
    @State private var favoritedTrips = Set<String>()
    @State private var locationImages = ["Portland_1", "SanDiego_1", "Vegas_1", "Orleans_1", "Bigbend_1" ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myBrown"))
                .frame(height: 125)
                .overlay(
                    HStack{
                        Text("COMPLETED TRIPS")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                    }
                    .padding(.top, 70)
                    
                )
            
            Button(action: {
                print("Edit tapped")
                // Add your edit action here
            }) {
                Text("Edit")
                    .font(.body)
                    .foregroundColor(Color("myTeal"))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .bold()
            }
            
            HStack {
                Toggle(isOn: $isFavoriteToggled) {
                    Text("Favorites")
                        .font(.body)
                        .foregroundColor(.black)
                }
                .tint(Color("myTeal"))
                .labelsHidden()
                .padding(.leading)
                Text("Show favorites")
                    .bold()
                    .foregroundColor(Color("myTeal"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(completedTrips.enumerated()), id: \.offset) { index, trip in
                        // Each block with shadow
                        ZStack {
                            VStack {
                                // If there's a matching image, display it
                                ZStack(alignment: .topTrailing){
                                    if index < locationImages.count {
                                        Image(locationImages[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fill) // Ensure the image fills the frame
                                            .frame(width: 100, height: 100)  // Set the size explicitly
                                            .clipped()  // Crop the image if necessary
                                            .cornerRadius(10)
                                        
                                        Button(action: {
                                            if favoritedTrips.contains(trip) {
                                                favoritedTrips.remove(trip)
                                            } else {
                                                favoritedTrips.insert(trip)
                                            }
                                        }) {
                                            Image(systemName: favoritedTrips.contains(trip) ? "star.fill" : "star")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(favoritedTrips.contains(trip) ? .white : .gray)
                                                .padding(.trailing, 5)
                                                .padding(.top, 5)
                                        }
                                    }
                                }
                                
                                // Location name
                                Text(trip)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 15))
                                    .padding(.top, 5)
                                    .padding(.leading)
                                    .padding(.bottom)
                                    .padding(.trailing, 2)
                               // Spacer()
                            }
                            .font(.body)
                            .frame(width: 120, height: 175)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            HStack {
                Image(systemName: "globe") // Replace with your own image if needed
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40) // Adjust the size as necessary
                    .foregroundColor(Color("myBrown"))
                
                Text("5/10 Completed Trips")
                    .font(.body)
                    .foregroundColor(Color("myBrown"))
                    .bold()
            }
            .padding(.bottom, 100)
                
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("myBeige"))
        .ignoresSafeArea()
    }
    
}

#Preview {
    CompletedPage()
}
