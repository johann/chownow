//
//  TestingURLProtocol.swift
//  chowNowTests
//
//  Created by Johann Kerr on 8/25/21.
//

import Foundation

/// Used to mock out Networking operations in tests
class TestingURLProtocol: URLProtocol {

    /// Data used for the network response. Subclasses can override to provide `Data`, for example an object encoding using a `JSONEncoder`. Can be `nil` if the subclass is designed to set an error
    var encodedResponse: Data? {
        return nil
    }

    /// Subclasses used to simulate an error can override to provide the error
    var error: Error? {
        return nil
    }

    /// Subclasses can override to provide a status code
    var statusCode: Int {
        0
    }

    // MARK: - URLProtocol methods
    /// Determines whether the protocol can handle the request - since this is an isolated enviornment, always returns `true`
    /// - Parameter request: the request
    /// - Returns:  `true`
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    /// Always returns argument
    /// - Parameter request: the `URLRequest` that is returned
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    /// Informs this instance's `client` instance of `protocol` of the response or error
    override func startLoading() {
        if let encodedResponse = encodedResponse {
            client?.urlProtocol(self, didLoad: encodedResponse)

            let httpURLResponse = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "1.1", headerFields: nil)
            client!.urlProtocol(self, didReceive: httpURLResponse!, cacheStoragePolicy: .allowed)
        } else if let error = error {
            client!.urlProtocol(self, didFailWithError: error)
        }

        client!.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
