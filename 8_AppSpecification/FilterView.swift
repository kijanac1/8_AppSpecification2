import SwiftUI

struct FilterView: View {
    @State private var selectedRegion = "None"
    @State private var selectedClimate = "None"
    @State private var selectedAccessibility = "None"
    @State private var selectedActivities = "None"
    
    @State private var showingRegionSelection = false
    @State private var showingClimateSelection = false
    @State private var showingAccessibilitySelection = false
    @State private var showingActivitiesSelection = false

    let regions = ["None", "North America", "Europe", "Asia", "Oceania"]
    let climates = ["None", "Tropical", "Desert", "Temperate", "Polar"]
    let accessibilityOptions = ["None", "Wheelchair Accessible", "Public Transport", "Walking Distance"]
    let activities = ["None","Hiking", "Swimming", "Shopping", "Dining"]

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
            
            VStack {
                
                
                Text("Filter Search")
                    .font(.system(size: 24))
                    .foregroundColor(Color("myGreen"))
                    .bold()
                    .padding()
                
                ZStack {
                    // Stationary rectangle as the background
                    Rectangle()
                        .fill(Color("myBeige"))
                        .cornerRadius(15)
                        .frame(width: 375, height: 500)  // Adjust the size as needed
                        .shadow(radius: 5)
                    
                    VStack(spacing: 20) {
                        // Button for Region Selection
                        Button(action: {
                            showingRegionSelection.toggle()
                        }) {
                            HStack {
                                Text("Region: \(selectedRegion)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .foregroundColor(Color("myTeal"))
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        .sheet(isPresented: $showingRegionSelection) {
                            SelectionView(title: "Select Region", options: regions, selectedOption: $selectedRegion)
                        }
                        
                        // Button for Climate Selection
                        Button(action: {
                            showingClimateSelection.toggle()
                        }) {
                            HStack {
                                Text("Climate: \(selectedClimate)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .foregroundColor(Color("myTeal"))
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        .sheet(isPresented: $showingClimateSelection) {
                            SelectionView(title: "Select Climate", options: climates, selectedOption: $selectedClimate)
                        }
                        
                        // Button for Accessibility Selection
                        Button(action: {
                            showingAccessibilitySelection.toggle()
                        }) {
                            HStack {
                                Text("Accessibility: \(selectedAccessibility)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .foregroundColor(Color("myTeal"))
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        .sheet(isPresented: $showingAccessibilitySelection) {
                            SelectionView(title: "Select Accessibility", options: accessibilityOptions, selectedOption: $selectedAccessibility)
                        }
                        
                        // Button for Activities Selection
                        Button(action: {
                            showingActivitiesSelection.toggle()
                        }) {
                            HStack {
                                Text("Activities: \(selectedActivities)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .foregroundColor(Color("myTeal"))
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        .sheet(isPresented: $showingActivitiesSelection) {
                            SelectionView(title: "Select Activity", options: activities, selectedOption: $selectedActivities)
                        }
                        
                    }
                    .padding(.horizontal, 20)  // Adjust the spacing within the beige box
                }
            }
            
        } // VStack
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

// Selection View for Pop-Up
struct SelectionView: View {
    let title: String
    let options: [String]
    @Binding var selectedOption: String

    var body: some View {
        NavigationView {
            List(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilterView()
}
