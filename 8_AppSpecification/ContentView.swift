//
//  ContentView.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var hideTabBar = false
    
    init() {
            // Set the background color of the tab bar
            UITabBar.appearance().backgroundColor = UIColor(named: "myGreen")
            
            // Set the color of the unselected tab bar items
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "myTeal")
        }
    
    var body: some View {
        TabView {
            // First Tab (Home)
            DiscoveryPage(hideTabBar: $hideTabBar)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            // Second Tab (Bucketlist)
            VStack {
                BucketlistPage()
                //Spacer()
            }
            .tabItem {
                Label("Bucketlist", systemImage: "checklist")
            }

            // Third Tab (Completed Trips)
            VStack {
                Text("Suitcase Page")
                Spacer()
            }
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
