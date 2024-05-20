//
//  ApiClient.swift
//  chowNow
//
//  Created by Johann Kerr on 8/25/21.
//

import Combine
import Foundation
import UIKit

final class ApiClient {

    // MARK: Properties
    private let urlSession: URLSession

    // MARK: Initialization
    init(networkServices: [AnyClass]? = nil) {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        if let networkServices = networkServices {
            configuration.protocolClasses = networkServices
        }
        self.urlSession = URLSession(configuration: configuration)
    }

    public func fetchCompany(for id: Int) async throws -> Company {
        let url = url(for: id)
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let (data, response) = try await urlSession.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIClientError.networkResponseError
        }

        let company = try decoder.decode(Company.self, from: data)
        return company
    }

    private func url(for companyId: Int) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.chownow.com"
        urlComponents.path = "/api/company/\(companyId)"
        guard let url = urlComponents.url else {
            fatalError("Failed to construct URL")
        }
        return url
    }
}

// MARK: APIClientError
enum APIClientError: Error, Equatable {
    case networkResponseError
}

extension APIClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        default:
            return "\(Strings.APIClientError.defaultMessage) \(self)"
        }
    }
}

struct Strings {
    struct APIClientError {
        static let defaultMessage = "Something has gone wrong. Contact support."
    }
}
