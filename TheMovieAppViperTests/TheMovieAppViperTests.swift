//
//  TheMovieAppViperTests.swift
//  TheMovieAppViperTests
//
//  Created by Aji Saputra Raka Siwi on 16/02/21.
//

import XCTest
import Core

class TheMovieAppViperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
      XCTAssertEqual(Utils.changeDateStringIntoFormattedString(withStringDate: "2020-01-01"), "01 Januari 2020") 
    }

}
