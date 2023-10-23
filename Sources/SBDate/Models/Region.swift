import SBFoundation

/// Defines a context both for `Date` and `DateInRegion`.
/// - Author: Scott Brenner | SBDate
public struct Region: Codable, Hashable, Sendable {
    
    /// Calendar associated with region.
    /// - Author: Scott Brenner | SBDate
    public let calendar: Calendar
}

extension Region {
    
    /// Locale associate with region.
    /// - Author: Scott Brenner | SBDate
    public var locale: Locale { calendar.locale! }
    
    /// Timezone associated with region.
    /// - Author: Scott Brenner | SBDate
    public var timeZone: TimeZone { calendar.timeZone }
    
    /// The default region that is assigned to a new `Date`
    /// - Author: Scott Brenner | SBDate
    public static var `default`: Region { .UTC }
    
    /// Returns a region with a gregorian calendar, GMT timezone, and the user's autoupdating current locale.
    /// - Author: Scott Brenner | SBDate
    public static var UTC: Region {
        Region(calendar: .autoupdatingCurrent, timeZone: .gmt, locale: .autoupdatingCurrent)
    }
    
    /// Returns a region with all attribute set the device's autoupdating current values.
    /// - Author: Scott Brenner | SBDate
    public static var current: Region {
        Region(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, locale: .autoupdatingCurrent)
    }
    
    /// Initialize a new region with the given parameters.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter calendar: Calendar for region. If no calendar is specified, `Region.default`'s calendar is used.
    /// - Parameter timeZone: Timezone for region. If no timezone is specified, `Region.default`'s calendar is used.
    /// - Parameter locale: Locale for region. If no locale is specified, `Region.default`'s locale is used.
    public init(
        calendar: Calendar = Region.default.calendar,
        timeZone: TimeZone = Region.default.timeZone,
        locale: Locale = Region.default.locale
    ) {
        var calendar = calendar
        calendar.locale = locale
        calendar.timeZone = timeZone
        self.calendar = calendar
    }
    
    /// Initialize a new region by reading the `calendar`, `timeZone` and `locale` parameters from a given `DateComponents` instance.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter components: `DateComponents`.
    public init(from components: DateComponents) {
        let calendar = components.calendar ?? .gregorian
        let timeZone = components.timeZone ?? .current
        let locale = components.calendar?.locale ?? Locale.current
        self.init(calendar: calendar, timeZone: timeZone, locale: locale)
    }
    
    /// Returns the current date expressed into the receiver region.
    /// - Author: Scott Brenner | SBDate
    public func nowInThisRegion() -> DateInRegion {
        DateInRegion(Date(), region: self)
    }
}

extension Region: Equatable {
    
    public static func ==(lhs: Region, rhs: Region) -> Bool {
        // Note: equality does not consider other parameters than the identifier of the major
        // attributes (calendar, timezone and locale). Deeper comparison must be made directly
        // between Calendar (it may fail when you encode/decode autoUpdating calendars).
        (lhs.calendar.identifier == rhs.calendar.identifier) &&
        (lhs.timeZone.identifier == rhs.timeZone.identifier) &&
        (lhs.locale.identifier == rhs.locale.identifier)
    }
}

extension Region: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        "{calendar='\(calendar.identifier)', timezone='\(timeZone.identifier)', locale='\(locale.identifier)'}"
    }
}
