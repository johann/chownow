//
//  LocationMapView.swift
//  chowNow
//
//  Created by Johann Kerr on 5/19/24.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

struct LocationMapView: View {

    // MARK: Properties
    private let name: String
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees
    private var position: MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }

    // MARK: Initialization
    init(
        name: String,
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    var body: some View {
        Map(
            initialPosition: position,
            interactionModes: [.rotate, .zoom]
        )
        {
            Annotation(
                name,
                coordinate: CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                )
            ) {
                VStack(spacing: 0) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "tag.fill")
                                .foregroundStyle(Color.frosting)
                                .font(.system(size: 15))
                        )

                    Text(name)
                        .font(.caption2)
                        .foregroundStyle(Color.squidInk)
                }
            }
            .annotationTitles(.hidden)
        }
        .mapStyle(.standard)
    }
}

#Preview {
    return LocationMapView(name: "H Cafe", latitude: 33.9782562, longitude: -118.4059067)
}

