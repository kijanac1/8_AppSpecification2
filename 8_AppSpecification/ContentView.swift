//
//  ContentView.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        // Set the background color of the tab bar
        UITabBar.appearance().backgroundColor = UIColor(named: "myGreen")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "myTeal")
    }
    
    var body: some View {
        TabView() {
            // First Tab (Home)
            DiscoveryPage()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            // Second Tab (Bucketlist)
            BucketlistPage()
                .tabItem {
                    Label("Bucketlist", systemImage: "checklist")
                }

            // Third Tab (Completed Trips)
            CompletedPage()
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
