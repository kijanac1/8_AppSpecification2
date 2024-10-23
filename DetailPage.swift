//
//  DescriptionPage.swift
//  8_AppSpecification
//
//  Created by user264779 on 10/22/24.
//

import SwiftUI

struct DetailPage: View {
    var body: some View {
        VStack {
            // Image at the top
            Image("Fiji_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipped()
                .padding(.top)
            
            // Scrollable text box
            ScrollView {
                Text("Fiji is a tropical paradise located in the South Pacific Ocean, consisting of over 330 islands, with about 110 inhabited. Known for its pristine beaches, turquoise waters, and...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
            .frame(maxHeight: 200) // Set the height of the scrollable box
            
            Spacer()
        }
        .navigationTitle("Fiji, South Pacific Islands")
    }
}

#Preview {
    DescriptionPage()
}
