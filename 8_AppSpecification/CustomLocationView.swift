//  CustomLocationView.swift
//  8_AppSpecification
//
//  Created by Kayla Goldsmith on 10/23/24.
//
import SwiftUI

enum TargetPage {
    case bucketlist
    case completed
}

struct CustomLocationView: View {
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var description: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isPickerPresented: Bool = false
    @State private var isImageUploaded: Bool = false
    
    var targetPage: TargetPage
    var addLocationToBucketList: ((Location) -> Void)?
    var addLocationToCompleted: ((Location) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color("myTeal"))
                .frame(height: 125)
                .ignoresSafeArea(edges: .top) // Ensures the rectangle goes to the top of the screen
            
            VStack {
                Text("Add Custom Location")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("myGreen"))
                    .padding(.top, -40)
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("myBeige"))
                    .frame(width: 350, height: 550)
                    .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    .overlay(
                        VStack(spacing: 15) {
                            VStack(alignment: .leading) {
                                Text("City")
                                    .font(.headline)
                                    .foregroundColor(Color("myGreen"))
                                    .padding(.leading, 20)
                                TextField("Enter Name", text: $city)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .padding(.horizontal)
                            }
                            VStack(alignment: .leading) {
                                Text("Country")
                                    .font(.headline)
                                    .foregroundColor(Color("myGreen"))
                                    .padding(.leading, 20)
                                TextField("Enter Name", text: $country)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .padding(.horizontal)
                            }
                            VStack(alignment: .leading) {
                                Text("Description")
                                    .font(.headline)
                                    .foregroundColor(Color("myGreen"))
                                    .padding(.leading, 20)
                                TextField("Enter description or comments", text: $description)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .padding(.horizontal)
                            }
                            Button(action: {
                                isPickerPresented = true
                            }) {
                                HStack {
                                    Image(systemName: "arrow.up.doc.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    Text(isImageUploaded ? "Image uploaded successfully" : "Upload Image")
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .frame(width: 320, height: 50)
                                .background(Color("myBrown"))
                                .cornerRadius(8)
                            }
                            .sheet(isPresented: $isPickerPresented){
                                ImagePicker(selectedImage: $selectedImage, isImageUploaded: $isImageUploaded)
                            }
                            Spacer()
                            Button(action: {
                                handleSubmit()
                            }) {
                                Text("Done")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .frame(width: 320, height: 50)
                                    .background(Color("myTeal"))
                                    .cornerRadius(8)
                            }
                            Spacer()
                        }
                        .padding(.top, 40)
                    )
                Spacer()
            }
            .padding()
            //.background(Color("myBeige").ignoresSafeArea())
        }
    }
    
    private func handleSubmit() {
        guard !city.isEmpty, !country.isEmpty else{
            return
        }
        let newLocation = Location(city: city, country: country, description: description, image: selectedImage)
        switch targetPage{
        case .bucketlist:
            addLocationToBucketList?(newLocation)
        case .completed:
            addLocationToCompleted?(newLocation)
        }
    }
}

#Preview {
    CustomLocationView(targetPage: .bucketlist)
}
