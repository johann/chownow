//
//  CompanyTestingURLProtocol.swift
//  chowNowTests
//
//  Created by Johann Kerr on 8/27/21.
//

import Foundation
import XCTest

private let companyResponse = """
{
	"id": "1",
	"address": {
		"id": 1,
		"street_address1": "1700 Lincoln Blvd.",
		"street_address2": "Apt 6",
		"city": "Venice",
		"state": "CA",
		"zip": "90291",
		"country": "USA",
		"country_alpha2": "US",
		"geo": "33.9969063,-118.4579544",
		"latitude": 33.9969063,
		"longitude": -118.4579544,
		"name": null,
		"address_string": "1700 Lincoln Blvd.Apt 6Venice CA 90291",
		"formatted_address": "1700 Lincoln Blvd., Apt 6, Venice CA 90291",
		"place_formatted_address": "1700 Lincoln Blvd., Venice, CA 90291",
		"is_google_place": false
	},
	"android_app_url": "https://play.google.com/store/apps/details?id=com.chownow.hudsonscafe",
	"delivery_only": false,
	"has_apple_pay_enabled": false,
	"ios_app_store_id": null,
	"is_multi_concept": false,
	"locations": [{
		"id": "1",
		"address": {
			"id": 4630993,
			"street_address1": "12181 West Bluff Creek Drive",
			"street_address2": "",
			"city": "Playa Vista",
			"state": "CA",
			"zip": "90094",
			"country": "USA",
			"country_alpha2": "US",
			"geo": "33.9782562,-118.4059067",
			"latitude": 33.9782562,
			"longitude": -118.4059067,
			"name": null,
			"address_string": "12181 West Bluff Creek DrivePlaya Vista CA 90094",
			"formatted_address": "12181 West Bluff Creek Drive, Playa Vista CA 90094",
			"place_formatted_address": "12181 West Bluff Creek Drive, Playa Vista, CA 90094",
			"is_google_place": false
		},
		"allows_order_for_now": true,
		"company_id": "1",
		"display_properties": {
			"menu_disclaimer": "All delivery orders must be placed prior to 2pm day of or they won't be accepted.",
			"enable_special_instructions": true,
			"special_instructions_text": "YOU CAN CHANGE THIS TO SAY WHATEVER YOU WANT i.e. Add-on items listed in the Special Instructions box will not be honored."
		},
		"force_managed_delivery": false,
		"is_post_pay": false,
		"locale_name": "Santa Monica",
		"name": "The H Cafe - Santa Monica",
		"payment_processor_id": "3",
		"phone": "8887072469",
		"short_name": "The H Cafe - Santa Monica",
		"tax_rate": 9.250,
		"tax_type": null,
		"primary_cuisine": "American (New)",
		"cuisines": [
			"American (New)"
		],
		"delivery_only": false
	}],
	"name": "The H Cafe",
	"phone": "4242424878",
	"processor_key": "pk_live_1rHqZgeuWfzjo9nCVWMdRsbZUztUaNhhlxt4wHymS1kVK5MDf8dLcyjojGR487uMuZSeZyjKIraWRqrTKSoLfNzr000Bs7zTqEF"
}
""".data(using: .utf8)!

final class CompanyTesting200URLProtocol: TestingURLProtocol {
    override var encodedResponse: Data? {
        return companyResponse
    }

    override var statusCode: Int {
        return 200
    }
}

final class CompanyTesting403URLProtocol: TestingURLProtocol {
    override var statusCode: Int {
        return 403
    }
}
