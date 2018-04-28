//
//  Stock_Ticker_AppTests.swift
//  Stock Ticker AppTests
//
//  Created by Conor Sweeney on 4/25/18.
//  Copyright © 2018 Conor Sweeney. All rights reserved.
//

import XCTest
@testable import Stock_Ticker_App

class Stock_Ticker_AppTests: XCTestCase {
    var spManager1: StockPriceManager!
    var spManager2: StockPriceManager!
    var spManager3: StockPriceManager!
    var spManager4: StockPriceManager!


    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        spManager1 = StockPriceManager()
        spManager2 = StockPriceManager()
        spManager3 = StockPriceManager()
        spManager4 = StockPriceManager()

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        spManager1 = nil
        spManager2 = nil
        spManager3 = nil
        spManager4 = nil
    }
    
    func testNilParameter() {
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
