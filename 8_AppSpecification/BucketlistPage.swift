//
//  BucketlistPage.swift
//  8_AppSpecification
//
//  Created by Kayla Goldsmith on 10/21/24.
//
import SwiftUI

struct BucketlistPage: View {
   @State private var isEditing: Bool = false
   @State private var locations: [Location] = [
       Location(city: "Fiji", country: "South Pacific Islands", description: "Beautiful city 1", image: UIImage(named: "Fiji_1")),
       Location(city: "Leavenworth", country: "USA", description: "Beautiful city 2", image: UIImage(named: "leavenworth1")),
       Location(city: "Greece", country: "Italy", description: "Beautiful city 3", image: UIImage(named: "greece1")),
       Location(city: "Montego Bay", country: "Jamaica", description: "Beautiful city 4", image: UIImage(named: "montegobay1")),
       Location(city: "Santo Domingo", country: "Dominican Republic", description: "Beautiful city 4", image: UIImage(named:"santodomingo1"))
       ]
   @State private var showAlert = false
   @State private var selectedLocationIndex: Int?
   @State private var showAddLocationSheet = false
   @State private var showCustomLocationView = false
   @State private var showSearchLocationView = false

   var body: some View {
       NavigationStack {
           VStack(spacing: 0) {
               Rectangle()
                   .fill(Color("myEmerald"))
                   .frame(height: 125)
                   .overlay(
                       Text("BUCKET LIST")
                           .font(.title2)
                           .bold()
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity, alignment: .leading)
                           .padding(.leading)
                           .padding(.top, 70)
                   )
                   .ignoresSafeArea(edges: .top)

               Rectangle()
                   .fill(Color("myBeige"))
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .padding(.top, -61)
                   .overlay(
                       VStack(spacing: 20) {
                           HStack {
                               Spacer()
                               Button(action: {
                                   isEditing.toggle()
                               }) {
                                   Text(isEditing ? "Done" : "Edit")
                                       .foregroundColor(Color("myBrown"))
                                       .bold()
                               }
                               .padding(.trailing)
                           }
                           .padding(.top, -40)

                           ScrollView {
                               VStack(spacing: 10) {
                                   if !locations.isEmpty {
                                       ForEach(locations.indices, id: \.self) { locIndex in
                                           HStack {
                                               ZStack {
                                                   Rectangle()
                                                       .fill(Color.white)
                                                       .cornerRadius(15)
                                                       .frame(height: 80)
                                                       .padding(.top, -20)
                                                       .padding(20)
                                                       .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
                                                   Image(uiImage: locations[locIndex].image ?? UIImage())
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fill)
                                                           .frame(width: 70, height: 70)
                                                           .clipped()
                                                           .cornerRadius(15)
                                                           .padding(.leading, -161)
                                                           .padding(.top, -20)
                                                           
                                                       Text((locations[locIndex].city))
                                                           .font(.headline)
                                                           .foregroundColor(.black)
                                                           .padding(.leading, 50)
                                                           .padding(.top, -20)
                                                           .frame(width: 225, alignment: .leading)

                                                   if isEditing {
                                                       HStack(spacing: 15) {
                                                           Spacer()
                                                           Button(action: {
                                                               print("Checked item at index \(locIndex)")
                                                           }) {
                                                               Image(systemName: "checkmark.circle.fill")
                                                                   .foregroundColor(Color("myTeal"))
                                                           }
                                                           Button(action: {
                                                               selectedLocationIndex = locIndex
                                                               showAlert = true
                                                           }) {
                                                               Image(systemName: "trash")
                                                                   .foregroundColor(Color("myTeal"))
                                                           }
                                                       }
                                                       .padding(.trailing, 25)
                                                       .padding(.top, -30)
                                                   }
                                               }
                                           }
                                           .padding(.horizontal, 15)
                                       }
                                   } else {
                                       Text("No locations available. Add new ones!")
                                           .foregroundColor(Color("myBrown"))
                                           .padding(.top, 50)
                                   }
                               }
                           }

                           // Add Location button
                           if !isEditing {
                               Button(action: {
                                   // Present action sheet to choose location type
                                   showAddLocationSheet = true
                               }) {
                                   HStack {
                                       Image(systemName: "plus")
                                           .font(.largeTitle)
                                           .foregroundColor(Color("myBrown"))
                                       Text("Add Location")
                                           .foregroundColor(Color("myBrown"))
                                           .bold()
                                   }
                                   .padding(.leading, 40)
                                   Spacer()
                               }
                               .padding(.bottom, 40)
                               .actionSheet(isPresented: $showAddLocationSheet) {
                                   ActionSheet(title: Text("Choose Option"), buttons: [
                                       .default(Text("Custom Location")) {
                                           showCustomLocationView = true
                                       },
                                       .default(Text("Search Location")) {
                                           showSearchLocationView = true
                                       },
                                       .cancel()
                                   ])
                               }
                           }
                       }
                   )

               Spacer()
           }
           .background(Color("myBeige"))
           .alert(isPresented: $showAlert) {
               Alert(
                   title: Text("Delete Location"),
                   message: Text("Are you sure you want to delete this location?"),
                   primaryButton: .destructive(Text("Delete")) {
                       if let index = selectedLocationIndex {
                           locations.remove(at: index)
                       }
                   },
                   secondaryButton: .cancel()
               )
           }
           .navigationDestination(isPresented: $showCustomLocationView) {
               CustomLocationView(targetPage: .bucketlist, addLocationToBucketList: { newLocation in
                   locations.append(newLocation)
                   showCustomLocationView = false
               })
           }
           .navigationDestination(isPresented: $showSearchLocationView) {
               SearchLocationView()
           }
       }
   }
}

#Preview {
   BucketlistPage()
}
