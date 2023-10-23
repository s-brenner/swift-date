import XCTest
@testable import SBDate

final class RegionTests: XCTestCase {
    
    let region = Region.current
    
    var now: DateInRegion!
    
    override func setUp() {
        super.setUp()
        now = region.nowInThisRegion()
    }
    
    override func tearDown() {
        now = nil
        super.tearDown()
    }
    
    func testInitFromDateComponents() {
        XCTAssertEqual(
            Region(from: DateComponents()),
            Region(calendar: Calendar(identifier: .gregorian), timeZone: .current, locale: Locale.current)
        )
    }
    
    func testRegionConversion() {
        let nowInDenver = now.in(region: TimeZone(identifier: "America/Denver")!.region)
        let nowInLosAngeles = now.in(region: TimeZone(identifier: "America/Los_Angeles")!.region)
        let hourDifference = abs(nowInDenver.hour - nowInLosAngeles.hour)
        XCTAssertEqual(nowInDenver.date, nowInLosAngeles.date)
        XCTAssertTrue(hourDifference == 1 || hourDifference == 23, "Hour difference is \(hourDifference).")
    }
    
    func testDebugDescription() {
        let description = "{calendar='\(region.calendar.identifier)', timezone='\(region.timeZone.identifier)', locale='\(region.locale.identifier)'}"
        XCTAssertEqual(region.debugDescription, description)
    }
    
    func testCodable() {
        let encodedJSON = try! JSONEncoder().encode(region)
        let decodedRegion = try! JSONDecoder().decode(Region.self, from: encodedJSON)
        XCTAssertEqual(region, decodedRegion)
    }
}
