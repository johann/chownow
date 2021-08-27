//
//  APIClient+CompanyTests.swift
//  chowNowTests
//
//  Created by Johann Kerr on 8/27/21.
//

import Combine
@testable import chowNow
import XCTest

class APIClient_CompanyTestsTests: XCTestCase {

    private var cancellable: AnyCancellable?

    func test200CompanyRequest() {
        let companyAPIExpectation = expectation(description: "Successful 200 response expectation")
        let apiClient = ApiClient(networkServices: [CompanyTesting200URLProtocol.self])
        cancellable = apiClient.fetchCompany(for: 1)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNil(error, "Request failed to load")
                }

                companyAPIExpectation.fulfill()
            }, receiveValue: { response in
                XCTAssertNotNil(response)
            })

        waitForExpectations(timeout: 60) { error in
            XCTAssertNil(error)
        }
    }

    func testInvalidResponseForCompanyRequest() {
        let companyAPIExpectation = expectation(description: "Invalid 403 response expectation")
        let apiClient = ApiClient(networkServices: [CompanyTesting403URLProtocol.self])
        cancellable = apiClient.fetchCompany(for: 1)
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                }

                companyAPIExpectation.fulfill()
            } receiveValue: { company in
                XCTAssertNil(company)
            }

        waitForExpectations(timeout: 60) { error in
            XCTAssertNil(error)
        }
    }

}
