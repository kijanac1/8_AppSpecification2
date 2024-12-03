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
    @Published var selectedAccessibility: String = "None"
    @Published var selectedActivities: String = "None"
}

struct ContentView: View {
    
    @StateObject private var travelData = TravelData()
    @StateObject private var filterState = FilterState()
    
    init() {
        // Set the background color of the tab bar
        UITabBar.appearance().backgroundColor = UIColor(named: "myGreen")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "myTeal")
    }
    
    var body: some View {
        TabView() {
            // (Home tab)
            DiscoveryPage()
                .environmentObject(travelData)
                .environmentObject(filterState)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            // (Bucketlist tab)
            BucketlistPage()
                .environmentObject(travelData)
                .tabItem {
                    Label("Bucketlist", systemImage: "checklist")
                }
            
            // (Completed Trips)
            CompletedPage()
                .environmentObject(travelData)
                .tabItem {
                    Label("Trips", systemImage: "suitcase")
                }
        }
        .accentColor(Color("myBeige"))
    }
}



#Preview {
    ContentView()
}
