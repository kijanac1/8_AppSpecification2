import SwiftUI


struct FilterView: View {
    @EnvironmentObject var filterState: FilterState
    @Binding var currentIndex: Int
    
    @State private var showingRegionSelection = false
    @State private var showingClimateSelection = false
    @State private var showingLanguageSelection = false
    @State private var showingActivitiesSelection = false
    
    // Temporary states for selections
    @State private var tempRegion: String = "None"
    @State private var tempClimate: String = "None"
    @State private var tempLanguage: String = "None"
    @State private var tempActivities: String = "None"

    let regions = ["None", "North America", "Europe", "Asia", "Oceania", "South America", "Africa"]
    let climates = ["None", "Tropical", "Desert", "Temperate", "Polar"]
    let languageOptions = ["None", "English", "Mandarin", "Spanish", "Arabic", "Portuguese", "French"]
    let activities = ["None", "Hiking", "Swimming", "Shopping", "Dining", "Skiing", "Camping"]

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
                    Rectangle()
                        .fill(Color("myBeige"))
                        .cornerRadius(15)
                        .frame(width: 375, height: 500)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 20) {
                        // Button for Region Selection
                        Button(action: {
                            tempRegion = filterState.selectedRegion // Sync temporary state with current state
                            showingRegionSelection.toggle()
                        }) {
                            HStack {
                                Text("Region: \(filterState.selectedRegion)")
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
                            SelectionView(
                                title: "Select Region",
                                options: regions,
                                currentIndex: $currentIndex, temporarySelection: $tempRegion,
                                onConfirm: {
                                    filterState.selectedRegion = tempRegion
                                }
                            )
                        }
                        
                        // Button for Climate Selection
                        Button(action: {
                            tempClimate = filterState.selectedClimate
                            showingClimateSelection.toggle()
                        }) {
                            HStack {
                                Text("Climate: \(filterState.selectedClimate)")
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
                            SelectionView(
                                title: "Select Climate",
                                options: climates,
                                currentIndex: $currentIndex, temporarySelection: $tempClimate,
                                onConfirm: {
                                    filterState.selectedClimate = tempClimate
                                }
                            )
                        }
                        
                        // Button for Language Selection
                        Button(action: {
                            tempLanguage = filterState.selectedLanguage
                            showingLanguageSelection.toggle()
                        }) {
                            HStack {
                                Text("Spoken Language: \(filterState.selectedLanguage)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .foregroundColor(Color("myTeal"))
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        .sheet(isPresented: $showingLanguageSelection) {
                            SelectionView(
                                title: "Select Language",
                                options: languageOptions,
                                currentIndex: $currentIndex, temporarySelection: $tempLanguage,
                                onConfirm: {
                                    filterState.selectedLanguage = tempLanguage
                                }
                            )
                        }
                        
                        // Button for Activities Selection
                        Button(action: {
                            tempActivities = filterState.selectedActivities
                            showingActivitiesSelection.toggle()
                        }) {
                            HStack {
                                Text("Activities: \(filterState.selectedActivities)")
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
                            SelectionView(
                                title: "Select Activity",
                                options: activities,
                                currentIndex: $currentIndex,
                                temporarySelection: $tempActivities,
                                onConfirm: {
                                    filterState.selectedActivities = tempActivities
                                }
                            )
                        }
                        .padding(.bottom, 50)
                        
                        Button(action: {
                            filterState.selectedRegion = "None"
                            filterState.selectedClimate = "None"
                            filterState.selectedLanguage = "None"
                            filterState.selectedActivities = "None"
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color("myBrown"))
                                    .cornerRadius(10)
                                    .frame(width: 175, height: 40)
                                Text("Reset Filters")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

// Selection View for Pop-Up
struct SelectionView: View {
    let title: String
    let options: [String]
    @Binding var currentIndex: Int
    @Binding var temporarySelection: String
    var onConfirm: () -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List(options, id: \.self) { option in
                Button(action: {
                    temporarySelection = option
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if temporarySelection == option {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss() // Dismiss without changes
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("OK") {
                        onConfirm() // Apply changes to the actual filter state
                        currentIndex = 0
                        presentationMode.wrappedValue.dismiss() // Dismiss after saving
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var sampleIndex = 0 // Define a State property for the preview

    return FilterView(currentIndex: $sampleIndex) // Pass the Binding of the State property
        .environmentObject(FilterState())
}
