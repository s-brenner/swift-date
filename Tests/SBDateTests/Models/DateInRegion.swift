import XCTest
@testable import SBDate

final class DateInRegionTests: XCTestCase {
    
    func testInit() {
        let components = DateComponents(calendar: .gregorian)
        XCTAssertEqual(DateInRegion(components: components, region: nil)?.region, components.region)
    }
    
    func testDistantPast() {
        XCTAssertEqual(DateInRegion.distantPast().date, .distantPast)
        XCTAssertEqual(DateInRegion.distantPast().region, .default)
    }
    
    func testDistantFuture() {
        XCTAssertEqual(DateInRegion.distantFuture().date, .distantFuture)
        XCTAssertEqual(DateInRegion.distantFuture().region, .default)
    }
    
    func testComparable() {
        XCTAssertLessThan(
            DateInRegion(timeIntervalSince1970: 0),
            DateInRegion(timeIntervalSince1970: 1)
        )
    }
    
    func testCodable() {
        let now = Date().inDefaultRegion()
        let encodedJSON = try! JSONEncoder().encode(now)
        let decodedDateInRegion = try! JSONDecoder().decode(DateInRegion.self, from: encodedJSON)
        XCTAssertEqual(now, decodedDateInRegion)
    }
}
