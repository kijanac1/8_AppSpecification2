import SwiftUI

struct CompletedPage: View {
    @EnvironmentObject var travelData: TravelData
    @State private var isFavoriteToggled = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var filteredTrips: [Int] {
        isFavoriteToggled
            ? travelData.completedTrips.filter { travelData.favorites.contains($0) }
            : travelData.completedTrips
    }

    var body: some View {
        NavigationStack {
            VStack {
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

                Button(action: {
                    print("Edit tapped")
                    // Add your edit action here
                }) {
                    Text("Edit")
                        .font(.body)
                        .foregroundColor(Color("myTeal"))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .bold()
                }

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
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
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
                                                    .frame(width: 100, height: 100)
                                                    .clipped()
                                                    .cornerRadius(10)

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
                                                        .padding(.trailing, 5)
                                                        .padding(.top, 5)
                                                }
                                            }
                                        }

                                        // Location name
                                        Text(travelData.locationNames[index])
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 15))
                                            .padding(.top, 5)
                                            .padding(.leading)
                                            .padding(.bottom)
                                            .padding(.trailing, 2)
                                    }
                                    .font(.body)
                                    .frame(width: 120, height: 175)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                                }
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove the default button styling
                        }
                    }
                    .padding()
                }

                Spacer()
                HStack {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("myBrown"))

                    Text("\(travelData.completedTrips.count)/\(travelData.locationNames.count) Completed Trips")
                        .font(.body)
                        .foregroundColor(Color("myBrown"))
                        .bold()
                }
                .padding(.bottom, 100)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color("myBeige"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CompletedPage()
        .environmentObject(TravelData())
}
