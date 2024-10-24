//
//  Location.swift
//  8_AppSpecification
//
//  Created by Kayla Goldsmith on 10/23/24.
//
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let description: String
    var image: UIImage?
}
