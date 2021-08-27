//
//  Restaurant.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation

struct Company: Codable {
    var address: Address
    var locations: [Location]
    var name: String
}
