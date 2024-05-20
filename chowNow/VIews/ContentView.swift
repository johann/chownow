//
//  ContentView.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Combine
import SwiftUI

struct ContentView: View {

    // MARK: Propertes
    @StateObject var viewModel = CompanyLocationViewModel()

    var body: some View {
        switch viewModel.state {
        case .loading:
            loading
        case .loaded(let company):
            LocationListView(company: company)
        case .error(let error):
            retryButton(error)
        }
    }

    // MARK: Private
    private var loading: some View {
        VStack(spacing: 4) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gojiBerry))
            Text("Loading Company")
                .foregroundStyle(Color.gojiBerry)
        }
    }

    private func retryButton(_ error: Error) -> some View {
        VStack {
            Text(error.localizedDescription)
                .foregroundStyle(.gojiBerry)

            Button {
                viewModel.retry()
            } label: {
                Label(
                    title: {
                        Text("Retry")
                            .fontWeight(.semibold)
                            .font(.body)
                    },
                    icon: {
                        Image(systemName: "arrow.clockwise")
                            .font(.body)
                    }
                )
                .padding()
                .foregroundColor(.white)
                .background(.gojiBerry)
                .cornerRadius(40)
            }

            Spacer()
        }
        .padding(.top, 24)
    }
}

#Preview {
    ContentView()
}
