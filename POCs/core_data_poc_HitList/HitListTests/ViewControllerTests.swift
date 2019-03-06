//
//  ViewControllerTest.swift
//  HitListTests
//
//  Created by Martin Schnurrenberger, mVISE AG on 06.03.19.
//  Copyright © 2019 Martin Schnurrenberger, mVISE AG. All rights reserved.
//

import XCTest

class ViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_title_is_The_List() {
     /*   let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myview = storyboard.instantiateInitialViewController() as! ViewController
        let _ = myview.view
        XCTAssertEqual("The List", myview.titleLabel!.text!)*/
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
        
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
