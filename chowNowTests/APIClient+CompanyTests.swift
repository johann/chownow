//
//  APIClient+CompanyTests.swift
//  chowNowTests
//
//  Created by Johann Kerr on 8/27/21.
//

@testable import chowNow
import Combine
import XCTest

class APIClient_CompanyTestsTests: XCTestCase {

    func test200CompanyRequest() async throws {
        let apiClient = ApiClient(networkServices: [CompanyTesting200URLProtocol.self])

        do {
            let company = try await apiClient.fetchCompany(for: 1)
            XCTAssertNotNil(company)
        } catch {
            XCTFail("Request failed with error: \(error)")
        }
    }

    func testInvalidResponseForCompanyRequest() async throws {
        let apiClient = ApiClient(networkServices: [CompanyTesting403URLProtocol.self])

        do {
            _ = try await apiClient.fetchCompany(for: 1)
            XCTFail("Expected error, but received a company")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
