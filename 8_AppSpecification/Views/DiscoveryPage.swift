import SwiftUI


struct DiscoveryPage: View {
    @EnvironmentObject var travelData: TravelData
    @EnvironmentObject var filterState: FilterState
    @State private var currentIndex = 0
    @State private var isSearching: Bool = false
    @State private var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool
    @State private var swipeOffset: CGFloat = 0 // to track the offset for animation
    @State private var navigateToCustomLocation = false
    @State private var navigateToDetailPage = false
    @State private var selectedLocation: String? = nil
    @State private var showPopup = false
    @State private var showNextCard = true
    @Binding var selectedTab: Int


    var filteredLocations: [String] {
        travelData.locationNames.filter { location in
            // Search text filter
            (searchText.isEmpty || location.lowercased().contains(searchText.lowercased()))
        }
    }
    
    var filteredByFilters: [String] {
        travelData.locationNames.filter { location in
            // Region filter
            (filterState.selectedRegion == "None" || travelData.locationRegions[location] == filterState.selectedRegion) &&
            
            // Climate filter (if applicable in your data model)
            (filterState.selectedClimate == "None" || travelData.locationClimates[location] == filterState.selectedClimate) &&
            
            // Accessibility filter (if applicable in your data model)
            (filterState.selectedLanguage == "None" || (travelData.locationLanguages[location]?.contains(filterState.selectedLanguage) ?? false)) &&
            
            // Activities filter (if applicable in your data model)
            (filterState.selectedActivities == "None" || travelData.locationActivities[location]?.contains(filterState.selectedActivities) == true)
        }
    }

    var body: some View {
        ZStack {

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
                                
                                NavigationLink(destination: FilterView(currentIndex: $currentIndex, selectedTab: $selectedTab)) {
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
                        
                        if filteredByFilters.isEmpty {
                            // Show "No matches found" message if no locations match the filters
                            VStack{
                                Spacer()
                                Text("No matches found")
                                    .foregroundColor(Color("myTeal"))
                                    .font(.system(size: 20))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 60)
                                Text("☹")
                                    .font(.system(size: 40))
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 5)
                                Text("Update your filters to find matching destinations")
                                    .foregroundColor(Color("myBrown"))
                                    .font(.system(size: 20))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 5)
                                    .padding(.horizontal, 50)
                                Spacer()
                            }
                        } else {
                            
                            if showNextCard{
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
                                                            .shadow(color: Color.black.opacity(1), radius: 10, x: 4, y: 2)
                                                            .padding(.leading)
                                                            .frame(width: 250, alignment: .leading)
                                                            .lineLimit(2)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 0)
                                                                    .fill(Color.black.opacity(0.3))
                                                                
                                                            )
                                                        
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
                                        HStack {
                                            
                                            Spacer()
                                            // Rewind Button
                                            Button(action: {
                                                // nothing
                                            }
                                            ) {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color("myBrown"))
                                                        .frame(width: 60, height: 60)
                                                    Image(systemName: "arrow.left")
                                                        .font(.title)
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            
                                            Spacer()
                                            // Add to Bucket List Button
                                            Button(action: {
                                                if let locationIndex = travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex]) {
                                                    if travelData.bucketList.contains(locationIndex) {
                                                        // Remove from bucket list if already present
                                                    } else {
                                                        // Add to bucket list if not present
                                                    }
                                                }
                                            }) {
                                                ZStack {
                                                    Circle()
                                                        .fill(travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex])
                                                            .flatMap { travelData.bucketList.contains($0) } == true
                                                              ? Color("myTeal") // Filled color if in bucket list
                                                              : Color.gray.opacity(0.3)) // Pale color if not in bucket list
                                                        .frame(width: 60, height: 60)
                                                    
                                                    Image(systemName: "airplane")
                                                        .font(.title)
                                                        .foregroundColor(travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex])
                                                            .flatMap { travelData.bucketList.contains($0) } == true
                                                                         ? .white // Filled color if in bucket list
                                                                         : .gray) // Pale color if not in bucket list
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            // Skip Button
                                            Button(action: {
                                                // nothing
                                            }
                                            ) {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color("myEmerald"))
                                                        .frame(width: 60, height: 60)
                                                    Image(systemName: "arrow.uturn.forward")
                                                        .font(.title)
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .padding(.bottom, 80)
                                        //.padding(.bottom, 95)
                                    }
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
                                                        .shadow(color: Color.black.opacity(1), radius: 10, x: 4, y: 2)
                                                    //.shadow(color: Color.gray.opacity(0.8), radius: 6, x: -4, y: -2)
                                                        .padding(.leading)
                                                        .frame(width: 250, alignment: .leading)
                                                        .lineLimit(2)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 0)
                                                                .fill(Color.black.opacity(0.3))
                                                            
                                                        )
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
                                    
                                    HStack {
                                        
                                        Spacer()
                                        // Rewind Button
                                        Button(action: {
                                            withAnimation(.easeOut(duration: 0.25)) {
                                                swipeOffset = -UIScreen.main.bounds.width // Swipe left
                                                showNextCard = true
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                let totalCount = filteredByFilters.isEmpty ? travelData.locationImages.count : filteredByFilters.count
                                                currentIndex = (currentIndex + 1) % totalCount
                                                swipeOffset = 0 // Reset position
                                            }
                                        }) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color("myBrown"))
                                                    .frame(width: 60, height: 60)
                                                Image(systemName: "arrow.left")
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                            }
                                        }

                                        Spacer()
                                        // Add to Bucket List Button
                                        Button(action: {
                                            if let locationIndex = travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex]) {
                                                if travelData.bucketList.contains(locationIndex) {
                                                    // Remove from bucket list
                                                    travelData.bucketList.removeAll { $0 == locationIndex }
                                                } else {
                                                    // Add to bucket list
                                                    travelData.bucketList.append(locationIndex)
                                                    // Show pop-up
                                                    withAnimation {
                                                        showPopup = true
                                                    }
                                                    // Hide pop-up after 2 seconds
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        withAnimation {
                                                            showPopup = false
                                                        }
                                                    }
                                                }
                                            }
                                        }) {
                                            ZStack {
                                                Circle()
                                                    .fill(travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex])
                                                        .flatMap { travelData.bucketList.contains($0) } == true
                                                          ? Color("myTeal") // Filled color if in bucket list
                                                          : Color.gray.opacity(0.3)) // Pale color if not in bucket list
                                                    .frame(width: 60, height: 60)
                                                
                                                Image(systemName: "airplane")
                                                    .font(.title)
                                                    .foregroundColor(travelData.locationNames.firstIndex(of: filteredByFilters[currentIndex])
                                                        .flatMap { travelData.bucketList.contains($0) } == true
                                                                     ? .white // Filled color if in bucket list
                                                                     : .gray) // Pale color if not in bucket list
                                                    .fontWeight(.bold)
                                            }
                                        }
                                            
                                        Spacer()

                                        // Skip Button
                                        Button(action: {
                                            withAnimation(.easeOut(duration: 0.25)) {
                                                swipeOffset = UIScreen.main.bounds.width // Swipe right
                                                showNextCard = false
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                let totalCount = filteredByFilters.isEmpty ? travelData.locationImages.count : filteredByFilters.count
                                                currentIndex = (currentIndex - 1 + totalCount) % totalCount
                                                swipeOffset = 0 // Reset position
                                            }
                                        }) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color("myEmerald"))
                                                    .frame(width: 60, height: 60)
                                                Image(systemName: "arrow.uturn.forward")
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.bottom, 80)
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
                                                showNextCard = true
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                currentIndex = (currentIndex + 1) % totalCount
                                                swipeOffset = 0
                                            }
                                        } else if value.translation.width > 50 { // Swipe right
                                            withAnimation(.easeOut(duration: 0.25)) {
                                                swipeOffset = UIScreen.main.bounds.width
                                                showNextCard = false
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
                    
                    }
                    .alert(isPresented: $showPopup) {
                        Alert(
                            title: Text("Added to bucketlist"),
                            message: nil,
                            dismissButton: nil // No manual dismissal button for auto-fading
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
                            locations: filteredLocations, // Only matched locations
                            images: filteredImages,       // Only matched images
                            onSelect: { selectedLocation in
                                if let index = travelData.locationNames.firstIndex(of: selectedLocation) {
                                    self.selectedLocation = selectedLocation // Set selected location
                                    currentIndex = index // Update the current index
                                    navigateToDetailPage = true // Trigger navigation to detail page
                                }
                                withAnimation {
                                    isSearching = false
                                    searchText = ""
                                }
                            }
                        )
                        .padding(.top, filteredByFilters.isEmpty ? -645 : -682) // Adjusted positioning for dropdown
                        .zIndex(0)
                        .background(
                            EmptyView() // Placeholder view
                                .navigationDestination(isPresented: $navigateToDetailPage) {
                                    if let selectedLocation = selectedLocation,
                                       let index = travelData.locationNames.firstIndex(of: selectedLocation) {
                                        DetailPage(
                                            images: travelData.locationImages[index],
                                            locationName: selectedLocation,
                                            description: travelData.descriptions[index],
                                            currentIndex: index
                                        )
                                    }
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
    @Previewable @State var selectedTab = 0
    
    DiscoveryPage(selectedTab: $selectedTab)
        .environmentObject(TravelData())
        .environmentObject(FilterState())
}
