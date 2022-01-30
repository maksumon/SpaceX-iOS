//
//  StringExtension.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 30/01/2022.
//

import Foundation

extension String {
    func formatISODateTime() -> String {
        var formattedDateTime = self
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        let date = isoDateFormatter.date(from: self)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"

        if let formattedDate = date {
            formattedDateTime = dateFormatter.string(from: formattedDate)
        } else {
           print("There was an error formatting the string to date")
        }
        
        return formattedDateTime
    }
}
