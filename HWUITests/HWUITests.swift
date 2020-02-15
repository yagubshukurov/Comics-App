//
//  HWUITests.swift
//  HWUITests
//
//  Created by Yagub Shukurov on 2/15/20.
//  Copyright © 2020 Yagub Shukurov. All rights reserved.
//

import XCTest

class HWUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testComicDetailItemsExistence() {
        
        let app = XCUIApplication()
        app.launch()
        
        app.tables.buttons["Blockchain\n2020-2-12"].tap()
        
        let comicTitle = app.staticTexts["ComicTitle"]
        let comicImage = app.images["ComicImage"]
        let comicAltText = app.staticTexts["ComicAltText"]
        
        XCTAssertTrue(comicTitle.exists)
        XCTAssertTrue(comicImage.exists)
        XCTAssertTrue(comicAltText.exists)
        
    }
}
