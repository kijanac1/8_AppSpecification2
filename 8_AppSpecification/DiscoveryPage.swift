import SwiftUI

struct DiscoveryPage: View {
    @EnvironmentObject var travelData: TravelData
    @State private var currentIndex = 0
    @State private var isSearching: Bool = false
    @State private var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool

    var filteredLocations: [String] {
        travelData.locationNames.filter { searchText.isEmpty || $0.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()

            // NavigationStack
            NavigationStack {
                VStack {
                    // Top color strip with "Discovery Page" text
                    Rectangle()
                        .fill(Color("myTeal"))
                        .frame(height: 125)
                        .overlay(
                            HStack {
                                Text("DISCOVERY PAGE")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: isSearching ? 0 : 200, alignment: .leading)
                                    .padding(.leading)
                                    .lineLimit(isSearching ? 1 : nil)

                                // Use SearchBarWithDropdown
                                SearchBarWithDropdown(
                                    searchText: $searchText,
                                    isSearching: $isSearching,
                                    locations: travelData.locationNames
                                ) { selectedLocation in
                                    if let index = travelData.locationNames.firstIndex(of: selectedLocation) {
                                        currentIndex = index
                                    }
                                }

                                NavigationLink(destination: FilterView()) {
                                    Image(systemName: "gearshape")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.top, 70)
                        )

                    // Main content area
                    ZStack {
                        Rectangle()
                            .fill(Color("myBeige"))
                            .cornerRadius(50)
                            .frame(width: 350, height: 600)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .padding(.top, -40)

                        VStack {
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
                                        NavigationLink(destination:
                                                        DetailPage(
                                                            images: travelData.locationImages[currentIndex],
                                                            locationName: travelData.locationNames[currentIndex],
                                                            description: travelData.descriptions[currentIndex],
                                                            currentIndex: currentIndex
                                                        )) {
                                            Image(travelData.locationImages[currentIndex][0])
                                                .resizable()
                                                .cornerRadius(15)
                                                .frame(width: 275, height: 285)
                                        }
                                        VStack {
                                            Text(travelData.locationNames[currentIndex])
                                                .foregroundColor(.white)
                                                .bold()
                                                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 2)
                                                .padding(.leading)
                                                .frame(width: 250, alignment: .leading)
                                                .lineLimit(2)
                                        }
                                        .padding(.top, 10)
                                    }
                                    .padding(.top, -75)
                                    Text(travelData.descriptions[currentIndex])
                                        .frame(width: 255, height: 115)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 15))
                                }
                                .padding(.top, 120)
                            }
                            .padding(.top, -50)

                            Button(action: {
                                currentIndex = (currentIndex + 1) % travelData.locationImages.count
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
                    }

                    // DropdownView
                    if isSearching && !filteredLocations.isEmpty {
                        let filteredImages = filteredLocations.compactMap { location in
                            if let index = travelData.locationNames.firstIndex(of: location) {
                                return travelData.locationImages[index].first
                            }
                            return nil
                        }

                        DropdownView(locations: filteredLocations, images: filteredImages) { selectedLocation in
                            if let index = travelData.locationNames.firstIndex(of: selectedLocation) {
                                currentIndex = index
                            }
                            withAnimation {
                                isSearching = false
                                searchText = ""
                            }
                        }
                        .padding(.top, -675) // Adjusted positioning for dropdown
                        .zIndex(1)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea(edges: .top)
            }
        }
    }
}

#Preview {
    DiscoveryPage()
        .environmentObject(TravelData())
}
