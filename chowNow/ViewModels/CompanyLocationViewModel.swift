//
//  CompanyLocationViewModel.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation
import Combine

class CompanyLocationViewModel: ObservableObject {

    enum State {
        case loading
        case loaded(Company)
        case error(Error)
    }

    // MARK: Defaults
    private var defaultCompanyId = 1

    // MARK: Properties
    @Published var state: State = .loading

    init() {
        fetchCompany()
    }

    func retry() {
        fetchCompany()
    }

    // MARK: Private
    private func fetchCompany() {
        state = .loading
        Task {
            do {
                let company = try await ApiClient().fetchCompany(for: defaultCompanyId)
                DispatchQueue.main.async {
                    self.state = .loaded(company)
                }
            } catch {
                self.state = .error(error)
            }
        }
    }
}
