//
//  ContentView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = CompanyLocationViewModel()
    var body: some View {
        if (viewModel.company != nil) {
            companyListView
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gojiBerry))
        }
    }

    private var companyListView: some View {
        viewModel.company.map(LocationListView.init)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
