import SwiftUI


struct DiscoveryPage: View {
    @EnvironmentObject var travelData: TravelData
    @State private var currentIndex = 0
    @State private var isSearching: Bool = false
    @State private var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool
    @State private var swipeOffset: CGFloat = 0 // to track the offset for animation
    @State private var navigateToCustomLocation = false
    @EnvironmentObject var filterState: FilterState


    var filteredLocations: [String] {
        travelData.locationNames.filter { location in
            // Search text filter
            (searchText.isEmpty || location.lowercased().contains(searchText.lowercased()))
        }
    }
    
    var filteredByFilters: [String] {
        travelData.locationNames.filter { location in
            // Region filter
            (filterState.selectedRegion == "None" || travelData.locationRegions[location] == filterState.selectedRegion) /*&&
            
            // Climate filter (if applicable in your data model)
            (filterState.selectedClimate == "None" || travelData.locationClimates?[location] == filterState.selectedClimate) &&
            
            // Accessibility filter (if applicable in your data model)
            (filterState.selectedAccessibility == "None" || travelData.locationAccessibility?[location] == filterState.selectedAccessibility) &&
            
            // Activities filter (if applicable in your data model)
            (filterState.selectedActivities == "None" || travelData.locationActivities?[location]?.contains(filterState.selectedActivities) == true) */
        }
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
                                
                                NavigationLink(destination: FilterView(currentIndex: $currentIndex)) {
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
                        // Next location, positioned below
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
                                            // Update to use filteredByFilters for the image
                                            if let imageIndex = travelData.locationNames.firstIndex(of: filteredByFilters[(currentIndex + 1) % filteredByFilters.count]) {
                                                Image(travelData.locationImages[imageIndex][0])
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .frame(width: 275, height: 285)
                                            }
                                            VStack {
                                                // Update to use filteredByFilters for the name
                                                Text(filteredByFilters[(currentIndex + 1) % filteredByFilters.count])
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
                                        
                                        // Update to use filteredByFilters for the description
                                        if let descriptionIndex = travelData.locationNames.firstIndex(of: filteredByFilters[(currentIndex + 1) % filteredByFilters.count]) {
                                            Text(travelData.descriptions[descriptionIndex])
                                                .frame(width: 255, height: 115)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 20))
                                        }
                                    }
                                    .padding(.top, 120)
                                }
                                .padding(.top, -50)
                                Button(action: {
                                    // No action
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
                        
                        // Existing current location ZStack
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
                                            if let originalIndex = travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex]) {
                                                NavigationLink(destination: DetailPage(
                                                    images: travelData.locationImages[originalIndex],
                                                    locationName: filteredByFilters[currentIndex],
                                                    description: travelData.descriptions[originalIndex],
                                                    currentIndex: originalIndex
                                                )) {
                                                    Image(travelData.locationImages[originalIndex][0])
                                                        .resizable()
                                                        .cornerRadius(15)
                                                        .frame(width: 275, height: 285)
                                                }
                                            }
                                            VStack {
                                                Text(filteredByFilters[currentIndex])
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
                                        
                                        if let descriptionIndex = travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex]) {
                                            Text(travelData.descriptions[descriptionIndex])
                                                .frame(width: 255, height: 115)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 20))
                                        }
                                    }
                                    .padding(.top, 120)
                                }
                                .padding(.top, -50)
                                
                                Button(action: {
                                    withAnimation(.easeOut(duration: 0.3)) {
                                        swipeOffset = -UIScreen.main.bounds.width
                                    }
                                    
                                    print(currentIndex)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        // Use filteredByFilters.count when filters are applied
                                        let totalCount = filteredByFilters.isEmpty ? travelData.locationImages.count : filteredByFilters.count
                                        currentIndex = (currentIndex + 1) % totalCount
                                        swipeOffset = UIScreen.main.bounds.width
                                        withAnimation(.easeOut(duration: 0.1)) {
                                            swipeOffset = 0
                                        }
                                    }
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
                        .offset(x: swipeOffset) // Apply offset to the entire ZStack
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    swipeOffset = value.translation.width
                                }
                                .onEnded { value in
                                    let totalCount = filteredByFilters.isEmpty ? travelData.locationImages.count : filteredByFilters.count
                                    if value.translation.width < -50 { // Swipe left
                                        withAnimation(.easeOut(duration: 0.25)) {
                                            swipeOffset = -UIScreen.main.bounds.width
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            currentIndex = (currentIndex + 1) % totalCount
                                            swipeOffset = 0
                                        }
                                    } else if value.translation.width > 50 { // Swipe right
                                        withAnimation(.easeOut(duration: 0.25)) {
                                            swipeOffset = UIScreen.main.bounds.width
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            currentIndex = (currentIndex - 1 + totalCount) % totalCount
                                            swipeOffset = 0
                                        }
                                    } else {
                                        withAnimation(.easeOut(duration: 0.2)) {
                                            swipeOffset = 0
                                        }
                                    }
                                }
                        )
                    }
                    
                    // DropdownView
                    if isSearching {
                        let filteredImages = filteredLocations.compactMap { location in
                            if let index = travelData.locationNames.firstIndex(of: location) {
                                return travelData.locationImages[index].first
                            }
                            return nil
                        }

                        DropdownView(
                            locations: ["Add custom location"] + filteredLocations, // Include "Add custom location"
                            images: [""] + filteredImages, // Placeholder image for "Add custom location"
                            onSelect: { selectedLocation in
                                if selectedLocation == "Add custom location" {
                                    navigateToCustomLocation = true // Trigger navigation
                                } else {
                                    if let index = travelData.locationNames.firstIndex(of: selectedLocation) {
                                        currentIndex = index
                                    }
                                    withAnimation {
                                        isSearching = false
                                        searchText = ""
                                    }
                                }
                            }
                        )
                        .padding(.top, -675) // Adjusted positioning for dropdown
                        .zIndex(1)
                        .background(
                            EmptyView() // Placeholder view
                                .navigationDestination(isPresented: $navigateToCustomLocation) {
                                    CustomLocationView(targetPage: .bucketlist) // Destination view
                                }
                        )
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
        .environmentObject(FilterState())
}
