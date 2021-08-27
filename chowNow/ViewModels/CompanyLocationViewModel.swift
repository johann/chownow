//
//  CompanyLocationViewModel.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation
import Combine

class CompanyLocationViewModel: ObservableObject {
    // MARK: Defaults
    private var defaultCompanyId = 1

    // MARK: Properties
    @Published var company: Company?
    var cancellable: AnyCancellable?

    init() {
        fetchCompany(for: defaultCompanyId)
    }

    // MARK: Private
    private func fetchCompany(for id: Int) {
        cancellable = ApiClient().fetchCompany(for: id)
            .mapError({ error -> Error in
                print(error)
                return error
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.company = $0
            })
    }
}
