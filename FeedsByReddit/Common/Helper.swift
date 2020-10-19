//
//  Helper.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/18/20.
//

import Foundation

struct Helper {
    
    static func formatDatetime(_ datetime: Double) -> String {
        let today = Date(timeIntervalSinceNow: 0)
        let createdAt = Date(timeIntervalSince1970: datetime)
        return String(Int((today.timeIntervalSinceReferenceDate - createdAt.timeIntervalSinceReferenceDate) / 3600)) + "h"
    }
}
