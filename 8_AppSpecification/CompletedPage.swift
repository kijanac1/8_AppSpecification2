import SwiftUI

struct CompletedPage: View {
    @EnvironmentObject var travelData: TravelData
    @State private var isFavoriteToggled = false

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

                // Favorites Toggle
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
                        print("Edit tapped")
                    }) {
                        Text("Edit")
                            .font(.body)
                            .foregroundColor(Color("myTeal"))
                            .padding(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 35)
                .padding(.top, 15)

                // Dynamic Grid
                ScrollView {
                    let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: UIScreen.main.bounds.width / 3 - 20)), count: 3)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredTrips, id: \.self) { index in
                            NavigationLink(
                                destination: DetailPage(
                                    images: travelData.locationImages[index],
                                    locationName: travelData.locationNames[index],
                                    description: travelData.descriptions[index],
                                    currentIndex: index
                                )
                            ) {
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
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 10)
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
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color("myBeige"))
            .ignoresSafeArea()
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
    CompletedPage()
        .environmentObject(TravelData())
}
