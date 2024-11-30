import SwiftUI

struct DiscoveryPage: View {
    @EnvironmentObject var travelData: TravelData
    @State private var currentIndex = 0
    @State private var isSearching: Bool = false
    @State private var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool
    @State private var swipeOffset: CGFloat = 0 // State variable to track the offset for animation
    

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
                                            Image(travelData.locationImages[(currentIndex + 1) % travelData.locationImages.count][0])
                                                .resizable()
                                                .cornerRadius(15)
                                                .frame(width: 275, height: 285)
                                            VStack {
                                                Text(travelData.locationNames[(currentIndex + 1) % travelData.locationNames.count])
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
                                        Text(travelData.descriptions[(currentIndex + 1) % travelData.descriptions.count])
                                            .frame(width: 255, height: 115)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 15))
                                    }
                                    .padding(.top, 120)
                                }
                                .padding(.top, -50)
                                Button(action: {
                                    // no action
                                }){
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
                        //.offset(x: swipeOffset > 0 ? -UIScreen.main.bounds.width : 0) // Keeps next location static until swipe begins
                        
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
                                    // Animate the transition to the left
                                    withAnimation(.easeOut(duration: 0.3)) {
                                        swipeOffset = -UIScreen.main.bounds.width
                                    }
                                    // After the animation completes, update the index and reset swipeOffset
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        // Ensure swipeOffset is reset after index is updated
                                        currentIndex = (currentIndex + 1) % travelData.locationImages.count
                                        swipeOffset = UIScreen.main.bounds.width // Pre-position for seamless transition
                                        withAnimation(.easeOut(duration: 0.1)) {
                                            swipeOffset = 0 // Slide new card into position
                                        }
                                    }
                                }){
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
                                    swipeOffset = value.translation.width // Update offset dynamically during swipe
                                }
                                .onEnded { value in
                                    if value.translation.width < -50 { // Swipe left
                                        withAnimation(.easeOut(duration: 0.25)) { // Smooth animation to left
                                            swipeOffset = -UIScreen.main.bounds.width
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { // Match animation duration
                                            currentIndex = (currentIndex + 1) % travelData.locationImages.count
                                            swipeOffset = 0
                                        }
                                    } else if value.translation.width > 50 { // Swipe right
                                        withAnimation(.easeOut(duration: 0.25)) { // Smooth animation to right
                                            swipeOffset = UIScreen.main.bounds.width
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            currentIndex = (currentIndex - 1 + travelData.locationImages.count) % travelData.locationImages.count
                                            swipeOffset = 0
                                        }
                                    } else { // Snap back to center
                                        withAnimation(.easeOut(duration: 0.2)) { // Shorter and smoother snap-back
                                            swipeOffset = 0
                                        }
                                    }
                                }
                        )
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
