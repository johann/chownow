//
//  Address.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation

struct Address: Codable {
    var id: Int
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    var city: String
}
