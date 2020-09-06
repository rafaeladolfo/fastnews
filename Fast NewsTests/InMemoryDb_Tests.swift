//
//  InMemoryDb_Tests.swift
//  Fast NewsTests
//
//  Created by Rafael Adolfo on 06/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//
import XCTest
@testable import Fast_News

class InMemoryDb_Tests: XCTestCase {
    
    
    override func setUp() {
        
    }

    
    func testSaveShouldAddHotNews() {
        //given
        let hotNews = HotNews()
        
        //when
        InMemoryDb.shared.save(model: hotNews)
        
        //then
        XCTAssert(InMemoryDb.shared.hotNews.count > 0)
    }
    
    func testRemoveAllShouldClearHotNews() {
        //given
        let hotNews = HotNews()
        InMemoryDb.shared.save(model: hotNews)
        
        //when
        InMemoryDb.shared.removeAll()
        
        //then
        XCTAssertTrue(InMemoryDb.shared.hotNews.count == 0, "HotNews array should be equal 0")
    }
    
    func testGetHotNewsShouldReturnHotNews() {
        //given
        let hotNews = HotNews()
        InMemoryDb.shared.save(model: hotNews)
        
        //when
        var result = InMemoryDb.shared.getHotNews()
        
        //then
        XCTAssertTrue(result.count > 0, "Result from getHotNews should not be equal 0")
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
