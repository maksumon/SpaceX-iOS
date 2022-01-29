//
//  Rocket.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import Foundation

struct Rocket: Codable {
    let flickrImages: [String]
    let name: String
    let wikipedia: String
    let details, id: String

    enum CodingKeys: String, CodingKey {
        case flickrImages = "flickr_images"
        case name, wikipedia
        case details = "description"
        case id
    }
}
