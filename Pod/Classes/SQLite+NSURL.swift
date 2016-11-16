//
//  SQLite+URL.swift
//  Pods
//
//  Created by Haizhen Lee on 16/3/1.
//
//

import Foundation
import SQLite

extension URL: SQLite.Value{
  public static var declaredDatatype: String {
    return String.declaredDatatype
  }
  
  public static func fromDatatypeValue(_ stringValue: String) -> URL {
    return URL(string:stringValue)!
  }
  
  public var datatypeValue: String {
    return self.absoluteString
  }
}

public extension QueryType{
  public subscript(column: Expression<URL>) -> Expression<URL> {
    return namespace(column)
  }
  public subscript(column: Expression<URL?>) -> Expression<URL?> {
    return namespace(column)
  }
}

public extension Row{
  public subscript(column: Expression<URL>) -> URL {
    return get(column)
  }
  public subscript(column: Expression<URL?>) -> URL? {
    return get(column)
  }
}
