//
//  CompanyDetailView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    var location: Location

    private var position: MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: location.address.latitude,longitude: location.address.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                mapView

                HStack {
                    Text("Address:")
                    Spacer()
                    Text(location.address.formattedAddress)
                }

                HStack {
                    Text("Phone:")
                    Spacer()
                    Link(location.formattedPhoneNumber, destination: URL(string: "tel:\(location.phone)")!)
                }

                VStack(alignment: .leading) {
                    Text("Cuisines:")
                    ForEach(location.cuisines, id: \.self) { cuisine in
                        Text(cuisine)
                    }

                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .navigationBarTitle(location.name ?? "", displayMode: .inline)
    }

    var mapView: some View {
        Map(initialPosition: position, interactionModes: [.rotate, .zoom])
            {

                Annotation(
                    location.name ?? "",
                    coordinate: CLLocationCoordinate2D(
                        latitude: location.address.latitude,
                        longitude: location.address.longitude
                    )
                ) {

                    VStack(spacing: 0) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "tag.fill")
                                    .resizable()
                                    .foregroundStyle(Color.frosting)
                                    .frame(width: 20, height: 20)
                            )

                        Text(location.name ?? "")
                            .font(.caption2)
                            .foregroundStyle(Color.squidInk)
                    }
                }
                .annotationTitles(.hidden)
            }
            .mapStyle(.standard)
            .frame(height: 350)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: 1, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562)
        let location = Location(address: address, name: "H Cafe", phone: "8887072469")
        LocationDetailView(location: location)
    }
}
