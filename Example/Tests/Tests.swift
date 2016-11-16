import UIKit
import XCTest
import SQLiteSwiftyJSON
import SQLite
import SwiftyJSON

class Tests: XCTestCase {
 
    var db:Connection?
    override func setUp() {
        super.setUp()
       db = try! Connection()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func testStringFromJSON(){
    let json = JSON(["name":"banxi"])
    let string = json.datatypeValue
    XCTAssertEqual("{\"name\":\"banxi\"}", string)
  }
  
  func testJSONToString(){
    let json = JSON(["name":"banxi"])
    let string = "{\"name\":\"banxi\"}"
    let result = JSON.fromDatatypeValue(string)
    XCTAssertEqual(json, result)
  }
  
  func testURLToString(){
    let string = "iosapp://banxi.com"
    let url = URL(string:string)!
    XCTAssertEqual(url, URL.fromDatatypeValue(string))
  }
  
  func testStringToURL(){
    let string = "iosapp://banxi.com"
    let url = URL(string:string)!
    XCTAssertEqual(string, url.datatypeValue)
  }
    
    func testJSONType() {
      let users = Table("users")
      let id = Expression<Int64>("id")
      let extras = Expression<JSON>("extras")
      try? db?.run(users.create { t in
        t.column(id, primaryKey:true)
        t.column(extras)
      })
     
      let json = JSON(["name":"banxi"])
      let insert = users.insert(extras <- json)
      let rowid = try! db!.run(insert)
      let banxi = try! db!.pluck(users.filter(id==rowid))
      XCTAssertNotNil(banxi)
      XCTAssertEqual(banxi![extras], json)
      
      
    }
  
  func testURLType() {
    let users = Table("users")
    let id = Expression<Int64>("id")
    let link = Expression<URL>("link")
    try? db?.run(users.create { t in
      t.column(id, primaryKey:true)
      t.column(link)
    })
    let string = "iosapp://banxi.com"
    let url = URL(string:string)!
    let insert = users.insert(link <- url)
    let rowid = try! db!.run(insert)
    let banxi = try! db!.pluck(users.filter(id==rowid))
    XCTAssertNotNil(banxi)
    XCTAssertEqual(banxi![link], url)
    
    
  }
  
}
