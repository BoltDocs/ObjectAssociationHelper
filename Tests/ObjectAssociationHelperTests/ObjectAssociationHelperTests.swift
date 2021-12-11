/*
 * MIT License
 * 
 * Copyright (c) 2021 Ethan Wong
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import XCTest

@testable import ObjectAssociationHelper

final class ObjectAssociationHelperTests: XCTestCase {

  var key = "testKey"

  func testAssociateObject() throws {
    let obj1 = NSObject()
    obj1.associateObject(key: &key, value: "associatedValue" as NSString)
    XCTAssert(obj1.associatedObject(key: &key, initializer: "initializedValue" as NSString) == "associatedValue")

    let obj2 = NSObject()
    XCTAssert(obj2.associatedObject(key: &key, initializer: "initializedValue" as NSString) == "initializedValue")
  }

  func testAssociateOptionalObject() throws {
    let obj1 = NSObject()
    obj1.associateObject(key: &key, value: "associatedValue" as NSString)
    XCTAssert(obj1.associatedOptionalObject(key: &key) == "associatedValue" as NSString)

    let obj2 = NSObject()
    obj2.associateOptionalObject(key: &key, value: nil as NSString?)
    XCTAssert(obj2.associatedOptionalObject(key: &key) == nil as NSString?)

    let obj3 = NSObject()
    XCTAssert(obj3.associatedOptionalObject(key: &key) == nil as NSString?)
  }

  func testAssociateStruct() throws {
    let obj1 = NSObject()
    obj1.associateStruct(key: &key, value: "associatedValue")
    XCTAssert(obj1.associatedStruct(key: &key, initializer: "initializedValue") == "associatedValue")

    let obj2 = NSObject()
    XCTAssert(obj2.associatedStruct(key: &key, initializer: "initializedValue") == "initializedValue")
  }

  func testAssociateOptionalStruct() throws {
    let obj1 = NSObject()
    obj1.associateOptionalStruct(key: &key, value: "associatedValue")
    XCTAssert(obj1.associatedOptionalStruct(key: &key) == "associatedValue")

    let obj2 = NSObject()
    obj2.associateOptionalStruct(key: &key, value: nil as String?)
    XCTAssert(obj2.associatedOptionalStruct(key: &key) == nil)

    let obj3 = NSObject()
    XCTAssert(obj3.associatedOptionalStruct(key: &key) == nil)
  }

  func testAssociateObjectCopy() throws {
    let obj1 = "Test1" as NSString
    obj1.associateStruct(key: &key, value: "associatedValue")
    let obj1Copy = obj1.copy() as! NSString
    XCTAssert(obj1Copy.associatedStruct(key: &key, initializer: "initializedValue") == "associatedValue")

    let obj2 = "Test2" as NSString
    let obj2Copy = obj2.copy() as! NSString
    XCTAssert(obj2Copy.associatedStruct(key: &key, initializer: "initializedValue") == "initializedValue")
  }

}
