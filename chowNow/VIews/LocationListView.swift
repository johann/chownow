//
//  LocationListView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation
import SwiftUI

struct LocationListView: View {
    
    // MARK: Properties
    private let company: Company
    @State private var searchText = ""
    
    private var searchResults: [Location] {
        if searchText.isEmpty {
            return company.locations
        } else {
            return company.locations.filter { location in
                location.name?.contains(searchText) ?? false
            }
        }
    }
    
    init(company: Company) {
        self.company = company
    }
    
    var body: some View {
        NavigationStack {
            list
                .navigationTitle(company.name)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(
                    Color.gojiBerry,
                    for: .navigationBar
                )
                .toolbarBackground(.visible, for: .navigationBar)
        }
        .tint(.gojiBerry)
        .searchable(text: $searchText)
    }
    
    var list: some View {
        ScrollView {
            LazyVStack {
                ForEach(searchResults) { location in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        listCell(location)
                    }
                }
            }
        }
        .padding(.top, 16)
    }
    
    func listCell(_ location: Location) -> some View {
        VStack {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: location.media?.coverImageUrl ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    Circle()
                        .fill(Color.gojiBerry)
                        .frame(width: 30, height: 30)
                }
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(location.name ?? "")
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundStyle(Color.squidInk)
                    
                    Text(location.address.city)
                        .font(.caption)
                        .foregroundStyle(Color.squidInk)
                }
                
                Spacer()
            }
            .padding(.bottom, 5)
            
            Divider()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    let address = Address(id: 1, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562, city: "Omaha")
    let address2 = Address(id: 2, formattedAddress: "11505 West Dodge Ave, Omaha NE 68154", latitude: -118.4059067, longitude: 33.9782562, city: "Omaha")
    let location = Location(address: address2, name: "H Cafe", phone: "8887072469", id: "1234")
    let company = Company(address: address, locations: [location], name: "H Cafe")
    return LocationListView(company: company)
}
