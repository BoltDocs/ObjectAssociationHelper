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

import Foundation

// Associated wrapper by WeZZard: https://wezzard.com/2015/10/09/associated-object-and-swift-struct/
// Type safe helpers inspired by Tikitu de Jager: https://medium.com/@ttikitu/swift-extensions-can-add-stored-properties-92db66bce6cd#.mx6ekrw16

private final class AssociatedStruct<T>: NSObject {

  public let value: T

  public init(_ value: T) { self.value = value }

}

public extension NSObject {

  func associatedObject<ValueType: AnyObject>(
    key: UnsafePointer<String>,
    initializer: @autoclosure () -> ValueType
  ) -> ValueType {
    return ObjectAssociationHelper.associatedObject(self, key: key, initializer: initializer())
  }

  func associateObject<ValueType: AnyObject>(
    key: UnsafePointer<String>,
    value: ValueType
  ) {
    ObjectAssociationHelper.associateObject(self, key: key, value: value)
  }

  func associatedOptionalObject<ValueType: AnyObject>(
    key: UnsafePointer<String>
  ) -> ValueType? {
    return ObjectAssociationHelper.associatedOptionalObject(self, key: key)
  }

  func associateOptionalObject<ValueType: AnyObject>(
    key: UnsafePointer<String>,
    value: ValueType?
  ) {
    ObjectAssociationHelper.associateOptionalObject(self, key: key, value: value)
  }

  func associatedStruct<ValueType: Any>(
    key: UnsafePointer<String>,
    initializer: @autoclosure () -> ValueType
  ) -> ValueType {
    return ObjectAssociationHelper.associatedStruct(self, key: key, initializer: initializer())
  }

  func associateStruct<ValueType: Any>(
    key: UnsafePointer<String>,
    value: ValueType
  ) {
    ObjectAssociationHelper.associateStruct(self, key: key, value: value)
  }

  func associatedOptionalStruct<ValueType: Any>(
    key: UnsafePointer<String>
  ) -> ValueType? {
    return ObjectAssociationHelper.associatedOptionalStruct(self, key: key)
  }

  func associateOptionalStruct<ValueType: Any>(
    key: UnsafePointer<String>,
    value: ValueType?
  ) {
    ObjectAssociationHelper.associateOptionalStruct(self, key: key, value: value)
  }

}

public struct ObjectAssociationHelper {

  public static func associatedOptionalObject<ValueType: AnyObject>(
    _ object: AnyObject,
    key: UnsafePointer<String>
  ) -> ValueType? {
    if let obj = objc_getAssociatedObject(object, key) as? ValueType {
      return obj
    }
    return nil
  }

  public static func associateOptionalObject<ValueType: AnyObject>(
    _ object: AnyObject,
    key: UnsafePointer<String>,
    value: ValueType?
  ) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }

  public static func associatedObject<ValueType: AnyObject>(
    _ object: AnyObject,
    key: UnsafePointer<String>,
    initializer: @autoclosure () -> ValueType
  ) -> ValueType {
    if let obj = objc_getAssociatedObject(object, key) as? ValueType {
      return obj
    }
    let obj = initializer()
    associateOptionalObject(object, key: key, value: obj)
    return obj
  }

  public static func associateObject<ValueType: AnyObject>(
    _ object: AnyObject,
    key: UnsafePointer<String>,
    value: ValueType
  ) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }

  public static func associatedOptionalStruct<ValueType: Any>(
    _ object: AnyObject,
    key: UnsafePointer<String>
  ) -> ValueType? {
    if let obj = objc_getAssociatedObject(object, key) as? AssociatedStruct<ValueType?> {
      return obj.value
    }
    return nil
  }

  public static func associateOptionalStruct<ValueType: Any>(
    _ object: AnyObject,
    key: UnsafePointer<String>,
    value: ValueType?
  ) {
    objc_setAssociatedObject(object, key, AssociatedStruct<ValueType?>(value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }

  public static func associatedStruct<ValueType: Any>(
    _ object: AnyObject,
    key: UnsafePointer<String>,
    initializer: @autoclosure () -> ValueType
  ) -> ValueType {
    if let obj = objc_getAssociatedObject(object, key) as? AssociatedStruct<ValueType> {
      return obj.value
    }
    let value = initializer()
    associateOptionalStruct(object, key: key, value: value)
    return value
  }

  public static func associateStruct<ValueType: Any>(
    _ object: AnyObject,
    key: UnsafePointer<String>,
    value: ValueType
  ) {
    objc_setAssociatedObject(object, key, AssociatedStruct<ValueType>(value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }

}
