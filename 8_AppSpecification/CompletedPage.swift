import SwiftUI

struct CompletedPage: View {
    @EnvironmentObject var travelData: TravelData
    @State private var isFavoriteToggled = false
    @State private var isEditing = false // State for Edit mode
    @State private var showAlert = false // State for showing the delete confirmation alert
    @State private var itemToDelete: Int? // Store the selected item to delete
    @Binding var selectedTab: Int

    var body: some View {
        NavigationStack {
            VStack {
                // Header
                Rectangle()
                    .fill(Color("myBrown"))
                    .frame(height: 125)
                    .overlay(
                        HStack {
                            Text("COMPLETED TRIPS")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                        .padding(.top, 70)
                    )

                Spacer()

                // Favorites Toggle and Edit Button
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

                    Button(action: {
                        isEditing.toggle() // Toggle edit mode
                    }) {
                        Text(isEditing ? "Done" : "Edit") // Change text dynamically
                            .font(.body)
                            .foregroundColor(Color("myTeal"))
                            .padding(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 35)
                .padding(.top, 6)

                // Dynamic Grid
                if !travelData.completedTrips.isEmpty {
                    ScrollView {
                        let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: UIScreen.main.bounds.width / 3 - 20)), count: 3)

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredTrips, id: \.self) { index in
                                if isEditing {
                                    // Edit mode: Tappable view to show delete confirmation
                                    Button(action: {
                                        itemToDelete = index
                                        showAlert = true // Show alert to confirm deletion
                                    }) {
                                        itemView(for: index, isEditing: true)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                } else {
                                    // View-only mode: Navigate to details
                                    NavigationLink(
                                        destination: DetailPage(
                                            images: travelData.locationImages[index],
                                            locationName: travelData.locationNames[index],
                                            description: travelData.descriptions[index],
                                            currentIndex: index
                                        )
                                    ) {
                                        itemView(for: index, isEditing: false)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                } else {
                    // No trips message
                    VStack(spacing: 15) {
                        Spacer()
                        
                        Text("No trips have been marked as completed.")
                            .foregroundColor(Color("myBrown"))
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("✈️ ")
                            .font(.system(size: 50))
                        Text("You can mark locations as completed by using your")
                            .foregroundColor(Color("myBrown"))
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .frame(width: 250) // Set the desired width
                            .padding(.horizontal, 30)
                        
                        NavigationLink(destination: EmptyView()) {
                            Text("BUCKET LIST.")
                                .foregroundColor(Color("myEmerald"))
                                .font(.system(size: 18, weight: .bold))
                                .padding(.top, -10)
                                .onTapGesture {
                                    selectedTab = 1 // Switch to the "Bucket list" tab
                                }
                        }
                        Spacer()
                    }
                }

                Spacer()

                // Footer
                HStack {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("myBrown"))

                    Text("\(travelData.completedTrips.count)/\(travelData.completedTrips.count + travelData.bucketList.count) Trips")
                        .font(.body)
                        .foregroundColor(Color("myBrown"))
                        .bold()
                }
                .padding(.bottom, 120)
            }
            .onDisappear {
                isEditing = false // Exit edit mode when navigating away
                showAlert = false
            }
                
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color("myBeige"))
            .ignoresSafeArea()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Trip"),
                    message: Text("Are you sure you want to delete this trip?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let item = itemToDelete {
                            travelData.completedTrips.removeAll { $0 == item } // Delete the item
                        }
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
        }
    }

    // Helper method to build the item view
    @ViewBuilder
    private func itemView(for index: Int, isEditing: Bool) -> some View {
        ZStack {
            VStack {
                // Display the image if available
                ZStack(alignment: .topTrailing) {
                    if index < travelData.locationImages.count {
                        Image(travelData.locationImages[index][0])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 85, height: 85)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.top, -22)

                        Button(action: {
                            if travelData.favorites.contains(index) {
                                travelData.favorites.remove(index)
                            } else {
                                travelData.favorites.insert(index)
                            }
                        }) {
                            Image(systemName: travelData.favorites.contains(index) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(travelData.favorites.contains(index) ? .white : .gray)
                                .padding(5)
                        }
                        .offset(x: 0, y: -20)
                    }
                }

                // Location name
                Text(travelData.locationNames[index])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 12))
                    .lineLimit(2)
                    .padding(.horizontal, 10)
            }
            .frame(width: 100, height: 150)
            .background(isEditing ? Color.pink.opacity(0.2) : Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)

            // Delete mode indicator
            if isEditing {
                VStack {
                    Spacer()
                    Text("Tap to delete")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.red)
                        .padding(5)
                        //.background(Color.white.opacity(0.8))
                        .cornerRadius(5)
                        //.padding(.bottom, 10)
                }
            }
        }
    }

    // Filtered Trips
    var filteredTrips: [Int] {
        isFavoriteToggled
            ? travelData.completedTrips.filter { travelData.favorites.contains($0) }
            : travelData.completedTrips
    }
}

#Preview {
    @Previewable @State var selectedTab = 1
    return CompletedPage(selectedTab: $selectedTab)
        .environmentObject(TravelData())
}

