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
    private var cancellable: AnyCancellable?

    // MARK: Initialization
    init(networkServices: [AnyClass]? = nil) {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        if let networkServices = networkServices {
            configuration.protocolClasses = networkServices
        }
        self.urlSession = URLSession(configuration: configuration)
    }

    public func fetchCompany(for id: Int) -> AnyPublisher<Company, Error> {
        let url = url(for: id)
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let resourcePublisher = urlSession.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    // throw error
                    throw APIClientError.networkResponseError
                }
                
                return output.data
            }
            .decode(type: Company.self, decoder: decoder)
            .eraseToAnyPublisher()

        cancellable = resourcePublisher.sink(receiveCompletion: {
            print("Received completion 1: \($0).")
        }, receiveValue: {_ in

        })

        return resourcePublisher

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
