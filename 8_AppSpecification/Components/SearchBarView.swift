import SwiftUI

struct SearchBarWithDropdown: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @FocusState private var isSearchFieldFocused: Bool

    let locations: [String]
    let onSelect: (String) -> Void

    private var filteredLocations: [String] {
        locations.filter { searchText.isEmpty || $0.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                .onTapGesture {
                    isSearchFieldFocused = false
                }

            // Search Bar
            VStack(spacing: 0) {
                HStack {
                    if isSearching {
                        TextField("Search locations", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($isSearchFieldFocused)
                            .padding(.top, -5)
                        

                        Button(action: {
                            withAnimation {
                                isSearching = false
                                isSearchFieldFocused = false
                                searchText = "" // Clear the search text
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.top, -5)
                        }
                    } else {
                        Button(action: {
                            withAnimation {
                                isSearching = true
                                isSearchFieldFocused = true
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, -3)
                        }
                    }
                }
                .padding(.top, 15)
                //.frame(maxWidth: .infinity)
                .cornerRadius(10)
                .zIndex(1) // Ensure the search bar is above the dropdown
            }
            
        }
    }
}

struct DropdownView: View {
    let locations: [String]
    let images: [String] // Array of image names corresponding to each location
    let onSelect: (String) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                // Existing Locations
                ForEach(Array(zip(locations, images)), id: \.0) { location, image in
                    HStack {
                        // Display the image next to the text
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding(.leading, 16)

                        Text(location)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.leading, 8)

                        Spacer()
                    }
                    .frame(height: 80)
                    .background(Color.white)
                    .onTapGesture {
                        onSelect(location)
                    }

                    Divider()
                        .background(Color.gray.opacity(0.5))
                }
            }
            .padding(.horizontal)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxHeight: 400) // Constrain height to prevent overflow
        .zIndex(100) // Ensure it appears on top of other views
    }
}
