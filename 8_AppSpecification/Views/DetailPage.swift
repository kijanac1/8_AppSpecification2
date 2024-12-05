//
//  DescriptionPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/22/24.
//

import SwiftUI

struct DetailPage: View {
    @EnvironmentObject var travelData: TravelData
    @State var images: [String]  // List of images
    @State var locationName: String  // Location name
    @State var description: String  // Location description
    @State var currentIndex: Int
    @State private var currentImageIndex = 0
    @State private var showAlert = false
    @State private var showPopup = false

    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .fill(Color("myTeal"))
                    .frame(height: 125)

                Spacer()
                HStack {
                    Text(locationName)
                        .foregroundColor(Color("myGreen"))
                        .bold()
                        .font(.system(size: 16))
                        //.padding(.top, 15)
                    
                    
                    NavigationLink(
                        destination: GuideView(
                            locationName: locationName,
                            currentIndex: currentIndex
                        )
                    ) {
                        Image(systemName: "book")
                            .font(.title)
                            .foregroundColor(Color("myBrown"))
                    }
                    //.padding(.top, 15)
                    Button(action: {
                        if let index = travelData.bucketList.firstIndex(of: currentIndex) {
                            // Remove if already in bucketList
                            travelData.bucketList.remove(at: index)
                            
                            // Show pop-up for "Removed from bucket list"
                            withAnimation {
                                showPopup = true
                            }
                            
                            // Hide pop-up after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showPopup = false
                                }
                            }
                        } else {
                            // Add to bucketList if not already present
                            travelData.bucketList.append(currentIndex)
                            
                            // Show the alert when the action is performed
                            showAlert = true
                        }
                    }) {
                        Image(systemName: travelData.bucketList.contains(currentIndex) ? "plus.square.fill" : "plus.square")
                            .font(.title)
                            .foregroundColor(travelData.bucketList.contains(currentIndex) ? Color("myEmerald") : Color("myBrown"))
                    }
                    //.padding(.top, 10)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Successfully added to your bucket list"),
                            dismissButton: .default(Text("Continue"))
                        )
                    }
                    
                }
                .padding(.top, 10)
                .padding(.bottom, 10)

                GeometryReader { geometry in
                    ZStack {
                        Image(images[currentImageIndex])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width + 2, height: 300)
                            .clipped()
                            .padding(.top, -15)

                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .cornerRadius(15)
                                    .frame(width: 370, height: 310)
                                    .shadow(radius: 5)

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
                            }
                            .offset(y: 280)
                        }

                        HStack {
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
                                currentImageIndex = (currentImageIndex + 1) % images.count
                            }) {
                                Image(systemName: "chevron.right")
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

            // Pop-up overlay
            if showPopup {
                VStack {
                    Text("Removed from bucket list")
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(.red)
                        .padding(10)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.opacity) // Smooth fade effect
                        .opacity(showPopup ? 1 : 0)

                    Spacer()
                }
                .offset(y: 350)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .allowsHitTesting(false) // Prevent pop-up from interfering with interactions
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    // Create a mock TravelData object with dummy data
    let mockTravelData = TravelData()
    mockTravelData.bucketList = [0, 1] // Example data in bucketList

    return DetailPage(
        images: ["Fiji_1", "Fiji_2"], // Replace with valid image names in your Assets folder
        locationName: "Fiji, South Pacific Islands",
        description: "Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands...",
        currentIndex: 0
    )
    .environmentObject(mockTravelData) // Provide the mock TravelData object to the preview
}
