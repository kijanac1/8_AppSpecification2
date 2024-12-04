//
//  ContentView.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/21/24.
//

import SwiftUI

class FilterState: ObservableObject {
    @Published var selectedRegion: String = "None"
    @Published var selectedClimate: String = "None"
    @Published var selectedLanguage: String = "None"
    @Published var selectedActivities: String = "None"
}

struct ContentView: View {
    
    @StateObject private var travelData = TravelData()
    @StateObject private var filterState = FilterState()
    @State private var selectedTab: Int = 0 // 0 for Home, 1 for Bucketlist, 2 for Trips
    
    init() {
        // Set the background color of the tab bar
        UITabBar.appearance().backgroundColor = UIColor(named: "myGreen")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "myTeal")
    }
    
    var body: some View {
        TabView(selection: $selectedTab) { // Bind the selected tab
            DiscoveryPage()
                .environmentObject(travelData)
                .environmentObject(filterState)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0) // Assign a tag to identify this tab
            
            BucketlistPage(selectedTab: $selectedTab)
                .environmentObject(travelData)
                .environmentObject(filterState)
                .tabItem {
                    Label("Bucketlist", systemImage: "checklist")
                }
                .tag(1) // Tag for Bucketlist
            
            CompletedPage()
                .environmentObject(travelData)
                .environmentObject(filterState)
                .tabItem {
                    Label("Trips", systemImage: "suitcase")
                }
                .tag(2) // Tag for Completed Trips
        }
        .accentColor(Color("myBeige"))
    }
}



#Preview {
    ContentView()
}
