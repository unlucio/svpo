//
//  sVpoTests.swift
//  sVpoTests
//
//  Created by Luciano Colosio on 6/12/15.
//  Copyright (c) 2015 Luciano Colosio. All rights reserved.
//

import Cocoa
import XCTest

class sVpoTests: XCTestCase {
    var vpo:sVpo!
    
    override func setUp() {
        super.setUp()
        let baseObj: NSDictionary = [
            "key1": [
                "foo1": [
                    "bar1": "bao",
                    "bar2": "bao"
                ],
                "foo2": [
                    "bar2": "bao"
                ],
                "foo3": [
                    "bar3": "bao"
                ]
            ],
            "key2": [
                "foo1": [
                    "bar1": "bao",
                    "bar2": "bao"
                ],
                "foo2": [
                    "bar2": "bao"
                ],
                "foo3": [
                    "bar3": "bao"
                ]
            ]
        ]
        
        self.vpo = sVpo(dictionary: baseObj)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDoenstCrashonRandomPath() {
        self.vpo.get("key1.blah.bar2");
        print("BOT PASSING!!!")
        XCTAssert(true, "Pass")
    }
    
    func testCanGetAValue() {
        let result: String = self.vpo.get("key1.foo2.bar2") as! String
        
        XCTAssert(result == "bao", "Cannot get value 'bao' from 'key1.foo2.bar2' path")
    }
    
    func testReturnsFallbackValueIfProvidedAndOtCannotFindPath() {
        let result: String = self.vpo.get("AGH", faultback: "not found") as! String
        XCTAssert(result == "not found", "Failed retriving value for unexisting key 'AGH' returns default value 'not found'")
    }
    
    func testReturnsFallbackValueIfProvidedAndOtCannotFindPathDeep() {
        let result: String = self.vpo.get("AGH.some.Error", faultback: "not found") as! String
        XCTAssert(result == "not found", "Retriving value for unexisting key 'AGH.some.Error' returns default value 'not found'")
    }
    
    func testReturnsNilValueIfNoFaultbackIsProvidedAndCannotFindPath() {
        let result: AnyObject? = self.vpo.get("AGH")
        XCTAssert(result == nil, "Failed retriving value for unexisting key 'AGH' returns nil if no default value is given")
    }
    
    
    func testCanFindThe1stUsableMatchingValueInAnArrayOfPaths() {
        let result: String = self.vpo.some(["key2.foo1.bar3", "key2.foo1.bar2", "key1.foo2.bar2"]) as! String
        XCTAssert(result == "bao", "Cannot get value 'bao' from paths list: key2.foo1.bar3, key2.foo1.bar2, key1.foo2.bar2")
    }
    
    func testReturnsNilValueIfNoFaultbackIsProvidedAndCannotFindPathinPathsList() {
        let result: AnyObject? = self.vpo.some(["key2.foo6.bar3", "key2.foo5.bar2", "key1.foo9.bar2"])
        XCTAssert(result == nil, "Failed retriving nil form list of unexistent paths: key2.foo6.bar3, key2.foo5.bar2, key1.foo9.bar2")
    }
    
    func testReturnsDefaultValueIfNoFaultbackIsProvidedAndCannotFindPathinPathsList() {
        let result: String = self.vpo.some(["key2.foo6.bar3", "key2.foo5.bar2", "key1.foo9.bar2"], faultback: "Default") as! String
        XCTAssert(result == "Default", "Failed retriving nill form list of unexistent paths: key2.foo6.bar3, key2.foo5.bar2, key1.foo9.bar2")
    }
}
