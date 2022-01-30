//
//  SpaceXModel.swift
//  Launch
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import Foundation

struct Launch: Codable {
    let links: Links?
    let rocket: String?
    let success: Bool?
    let details, launchpad, name, dateUTC: String?
    let upcoming: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case links, rocket, success, details, launchpad, name
        case dateUTC = "date_utc"
        case upcoming, id
    }
}

// MARK: - Links
struct Links: Codable {
    let patch: Patch
}

// MARK: - Patch
struct Patch: Codable {
    let small, large: String?
}
