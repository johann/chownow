//
//  Location.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation

struct Location: Codable {
    var address: Address
    var name: String?
    var phone: String
    var cuisines: [String] = []
}

extension Location: Identifiable {
    var id: Int {
        return address.id
    }
}
