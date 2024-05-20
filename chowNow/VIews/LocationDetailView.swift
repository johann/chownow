//
//  CompanyDetailView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {

    // MARK: Properties
    private let location: Location

    // MARK: Initialization
    public init(location: Location) {
        self.location = location
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            mapView
                .edgesIgnoringSafeArea(.all)

            detailView
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
        .navigationBarTitle(location.name ?? "", displayMode: .inline)
    }

    var detailView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Address:")
                    .foregroundStyle(Color.squidInk)

                Spacer()

                Text(location.address.formattedAddress)
                    .foregroundStyle(Color.squidInk)
            }

            HStack {
                Text("Phone:")
                    .foregroundStyle(Color.squidInk)

                Spacer()

                Link(location.formattedPhoneNumber, destination: URL(string: "tel:\(location.phone)")!)
            }

            VStack(alignment: .leading) {
                Text("Cuisines:")
                    .foregroundStyle(Color.squidInk)

                ForEach(location.cuisines, id: \.self) { cuisine in
                    Text(cuisine)
                        .foregroundStyle(Color.squidInk)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 24)
        .background(Color.white)
        .frame(maxWidth: .infinity)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }

    var mapView: some View {
        LocationMapView(
            name: location.name ?? "",
            latitude: location.address.latitude,
            longitude: location.address.longitude
        )
    }
}

#Preview {
    let address = Address(id: 1, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562, city: "Omaha")
    let location = Location(address: address, name: "H Cafe", phone: "8887072469", id: "1234")
    return LocationDetailView(location: location)
}
