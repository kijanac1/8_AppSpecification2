import SwiftUI

struct SearchLocationView: View {
    @State private var searchText: String = ""

    let locations = [
        Location(city: "Tokyo", country: "Japan", description: "Beautiful city 1", image: UIImage(named: "Japan_1")),
        Location(city: "Kyoto", country: "Japan", description: "Beautiful city 2", image: UIImage(named: "kyoto_1")),
        Location(city: "New Orleans", country: "USA", description: "Beautiful city 3", image: UIImage(named: "Orleans_1")),
        Location(city: "Portland", country: "USA", description: "Beautiful city 4", image: UIImage(named: "Portland_1")),
        Location(city: "Big Bend", country: "USA", description: "Beautiful city 5", image: UIImage(named: "Bigbend_1"))
    ]
    
    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return []
        } else {
            return locations.filter { location in
                location.city.lowercased().contains(searchText.lowercased()) ||
                location.country.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
                .ignoresSafeArea(edges: .top)

            VStack {
                HStack {
                    TextField("Search location", text: $searchText)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: {
                        // Optionally trigger search logic
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(Color("myGreen"))
                            .padding(.trailing, 10)
                    }
                }
                .padding(.top, -40)

                ScrollView {
                    VStack(spacing: 0) {
                        if !filteredLocations.isEmpty {
                            ForEach(filteredLocations.indices, id: \.self) { locIndex in
                                HStack {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.white)
                                            .cornerRadius(15)
                                            .frame(height: 80)
                                            .padding(.top, -20)
                                            .padding(10)
                                            .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)

                                        Image(uiImage: filteredLocations[locIndex].image ?? UIImage())
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .clipped()
                                            .cornerRadius(15)
                                            .padding(.leading, -176)
                                            .padding(.top, -20)

                                        Text(filteredLocations[locIndex].city)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.leading, 50)
                                            .padding(.top, -20)
                                            .frame(width: 225, alignment: .leading)
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.top, 40)
                            }
                        } else {
                            Text("No locations found.")
                                .foregroundColor(Color("myBrown"))
                                .padding(.top, 50)
                        }
                    }
                }
            }
        }
        .background(Color("myBeige"))
    }
}

#Preview {
    SearchLocationView()
}
