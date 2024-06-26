//
//  Location.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation

struct Location: Codable, Identifiable {
    var address: Address
    var name: String?
    var phone: String
    var cuisines: [String] = []
    var id: String
    var media: CoverImage?

    struct CoverImage: Codable {
        var coverImageUrl: String
    }

    var formattedPhoneNumber: String {
        let areaCode = String(phone.prefix(3))
        let centralOfficeCode = String(phone[phone.index(phone.startIndex, offsetBy: 3)..<phone.index(phone.startIndex, offsetBy: 6)])
        let lineNumber = String(phone.suffix(4))


        let formattedPhone = String(
            format: "(%@) %@-%@",
            areaCode,
            centralOfficeCode,
            lineNumber
        )
        return formattedPhone
    }
}
