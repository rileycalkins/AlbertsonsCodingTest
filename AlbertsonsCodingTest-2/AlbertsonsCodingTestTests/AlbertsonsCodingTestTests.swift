//
//  AlbertsonsCodingTestTests.swift
//  AlbertsonsCodingTestTests
//
//  Created by Riley Calkins on 11/22/22.
//

import XCTest
@testable import AlbertsonsCodingTest

final class AlbertsonsCodingTestTests: XCTestCase {
    let viewModel = ViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel.searchString = "OMG"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel.searchString = ""
        viewModel.clearItems()
    }

    func testSearchTerm() throws {
        XCTAssertEqual(viewModel.searchString, "OMG")
    }

    func testGetAcronyms() {
        viewModel.getAcronyms(for: viewModel.searchString) { response in
            XCTAssertTrue(response.count != 0)
        }
    }
}
