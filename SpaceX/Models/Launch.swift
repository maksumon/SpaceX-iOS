//
//  SpaceXModel.swift
//  Launch
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import Foundation

struct Launch: Codable {
    let rocket: String?
    let success: Bool?
    let details, launchpad, name, dateUTC: String?
    let upcoming: Bool?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case rocket, success, details, launchpad, name
        case dateUTC = "date_utc"
        case upcoming, id
    }
}

struct LaunchResponse: Codable {
    var launches: [Launch]
}
