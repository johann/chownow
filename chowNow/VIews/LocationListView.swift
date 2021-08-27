//
//  LocationListView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation
import SwiftUI

struct LocationListView: View {
    var company: Company

    var body: some View {
        NavigationView {
            List(company.locations) { location in
                NavigationLink(destination: LocationDetailView(location: location)) {
                    Text(location.name ?? "")
                        .font(.headline)
                }
            }
            .navigationTitle(company.name)
        }
        .foregroundColor(.squidInk)
        .accentColor(.gojiBerry)
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: 1, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562)
        let address2 = Address(id: 2, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562)
        let location = Location(address: address2, name: "H Cafe", phone: "8887072469")
        let company = Company(address: address, locations: [location], name: "H Cafe")
        return LocationListView(company: company)
    }
}
