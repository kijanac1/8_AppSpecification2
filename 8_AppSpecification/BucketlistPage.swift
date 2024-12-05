//
//  BucketlistPage.swift
//  8_AppSpecification
//
//  Created by Kayla Goldsmith on 10/21/24.
//
import SwiftUI

struct BucketlistPage: View {
    @EnvironmentObject var travelData: TravelData
    @EnvironmentObject var filterState: FilterState
    @Binding var selectedTab: Int
    @State private var isEditing: Bool = false
    @State private var showAlert = false
    @State private var showCongratsAlert = false
    @State private var selectedLocationIndex: Int?

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color("myEmerald"))
                    .frame(height: 125)
                    .overlay(
                        Text("BUCKET LIST")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top, 70)
                    )
                    .ignoresSafeArea(edges: .top)
                
                Rectangle()
                    .fill(Color("myBeige"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, -61)
                    .overlay(
                        VStack(spacing: 20) {
                            HStack {
                                Spacer()
                                // Edit Button
                                Button(action: {
                                    isEditing.toggle()
                                }) {
                                    Text(isEditing ? "Done" : "Edit")
                                        .foregroundColor(Color("myTeal"))
                                        .bold()
                                }
                                .padding(.trailing)
                            }
                            .padding(.top, -40)

                            ScrollView {
                                VStack(spacing: 10) {
                                    if !travelData.bucketList.isEmpty {
                                        ForEach(travelData.bucketList, id: \.self) { locIndex in
                                            NavigationLink(
                                                destination: DetailPage(
                                                    images: travelData.locationImages[locIndex],
                                                    locationName: travelData.locationNames[locIndex],
                                                    description: travelData.descriptions[locIndex],
                                                    currentIndex: locIndex
                                                )
                                            ) {
                                                HStack {
                                                    ZStack(alignment: .leading) {
                                                        // Background Rectangle
                                                        Rectangle()
                                                            .fill(Color.white)
                                                            .cornerRadius(15)
                                                            .frame(height: 80)
                                                            .padding(.horizontal, 10)
                                                            .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
                                                        
                                                        HStack(spacing: 10) {
                                                            // Travel Image
                                                            if let firstImageName = travelData.locationImages[locIndex].first {
                                                                Image(firstImageName)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .frame(width: 70, height: 70)
                                                                    .clipped()
                                                                    .cornerRadius(15)
                                                            }
                                                            
                                                            VStack(alignment: .leading, spacing: 5) {
                                                                // Travel Name
                                                                Text(travelData.locationNames[locIndex])
                                                                    .foregroundColor(.black)
                                                                    //.font(.headline)
                                                                    .font(.system(size: 14))
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            if isEditing {
                                                                // Action Buttons
                                                                HStack(spacing: 15) {
                                                                    Button(action: {
                                                                        withAnimation {
                                                                            selectedLocationIndex = locIndex
                                                                            showCongratsAlert = true
                                                                        }
                                                                    }) {
                                                                        Image(systemName: "checkmark.circle.fill")
                                                                            .foregroundColor(Color("myTeal"))
                                                                            .font(.title2)
                                                                    }
                                                                    
                                                                    Button(action: {
                                                                        withAnimation {
                                                                            selectedLocationIndex = locIndex
                                                                            showAlert = true
                                                                        }
                                                                    }) {
                                                                        Image(systemName: "trash")
                                                                            .foregroundColor(Color("myTeal"))
                                                                            .font(.title2)
                                                                    }
                                                                }
                                                                .padding(.trailing, 15)
                                                            }
                                                        }
                                                        .padding(.horizontal, 15)
                                                    }
                                                }
                                                .padding(.horizontal, 15)
                                                .transition(.slide)
                                            }
                                        }
                                    } else {
                                        Spacer()

                                        VStack(spacing: 15) {
                                            Spacer()
                                            Image(systemName: "text.badge.plus") // Add an icon
                                                .font(.system(size: 50))
                                                .foregroundColor(Color("myBrown"))
                                                .padding(.top, 100)
                                            //Spacer()
                                            Text("No items currently in your bucket list.")
                                                .foregroundColor(Color("myBrown"))
                                                .font(.system(size: 20, weight: .bold))
                                                .multilineTextAlignment(.center)
                                                .padding(.horizontal, 30)
                                            Text("Find new locations to add using the ")
                                                .foregroundColor(Color("myBrown"))
                                                .font(.system(size: 18))
                                                .multilineTextAlignment(.center)

                                            NavigationLink(destination: EmptyView()) {
                                                Text("DISCOVERY PAGE.")
                                                    .foregroundColor(Color("myEmerald"))
                                                    .font(.system(size: 18, weight: .bold))
                                                    .padding(.top, -10)
                                                    .onTapGesture {
                                                        selectedTab = 0 // Switch to the "Home" tab
                                                    }
                                            }
                                            
                                            
                                            
                                        }

                                            //Spacer()
                                    }
                                }
                            }
                        }
                    )
                Spacer()
            }
            .background(Color("myBeige"))
            .alert(isPresented: Binding(
                get: { showAlert || showCongratsAlert },
                set: { value in
                    if !value {
                        showAlert = false
                        showCongratsAlert = false
                    }
                }
            )) {
                if showAlert {
                    return Alert(
                        title: Text("Delete Location"),
                        message: Text("Are you sure you want to delete this location?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let index = selectedLocationIndex,
                               let bucketListIndex = travelData.bucketList.firstIndex(of: index) {
                                withAnimation {
                                    travelData.bucketList.remove(at: bucketListIndex)
                                }
                            }
                        },
                        secondaryButton: .cancel()
                    )
                } else {
                    return Alert(
                        title: Text("Congratulations!"),
                        message: Text("You have completed this trip! Would you like to add this trip to your completed trips?"),
                        primaryButton: .default(Text("Yes")) {
                            if let index = selectedLocationIndex,
                               let bucketListIndex = travelData.bucketList.firstIndex(of: index) {
                                withAnimation {
                                    travelData.bucketList.remove(at: bucketListIndex)
                                    travelData.completedTrips.append(index)
                                }
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .onDisappear {
                isEditing = false
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedTab = 1

    return BucketlistPage(selectedTab: $selectedTab)
        .environmentObject(TravelData())
        .environmentObject(FilterState())
}
