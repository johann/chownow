//
//  CompanyDetailView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    var location: Location
    @State private var region: MKCoordinateRegion? = nil
    var coordinate: CLLocationCoordinate2D?

    var body: some View {

        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.address.latitude, longitude: location.address.longitude)

        let binding = Binding(get: {
            return MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }, set: {
            self.region = $0
        })

        return
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Map(coordinateRegion: binding, annotationItems: [location]) { location in
                        MapPin(coordinate: coordinate)
                    }
                    .frame(height: 200)
                    HStack {
                        Text("Address:")
                        Spacer()
                        Text(location.address.formattedAddress)
                    }
                    .padding(.horizontal, 20)
                    HStack {
                        Text("Phone:")
                        Spacer()
                        Link(location.phone, destination: URL(string: "tel:\(location.phone)")!)
                    }
                    .padding(.horizontal, 20)
                    VStack(alignment: .leading) {
                        Text("Cuisines")
                        ForEach(location.cuisines, id: \.self) { cuisine in
                            Text(cuisine)
                        }

                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .navigationBarTitle(location.name ?? "", displayMode: .inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let address = Address(id: 1, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562)
        let location = Location(address: address, name: "H Cafe", phone: "8887072469")
        LocationDetailView(location: location)
    }
}
