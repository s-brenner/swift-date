import Foundation

extension DateComponents {
    
    /// The region associated with the receiver.
    /// - Author: Scott Brenner | SBDate
    public var region: Region { Region(from: self) }
    
    /// The current date minus the receiver's interval in the calendar for the default region.
    /// - Author: Scott Brenner | SBDate
    public var ago: Date { Region.default.calendar.date(byAdding: -self, to: Date())! }
    
    /// The current date plus the receiver's interval in the calendar for the default region.
    /// - Author: Scott Brenner | SBDate
    public var fromNow: Date { Region.default.calendar.date(byAdding: self, to: Date())! }
    
    /// Returns the date that occurred once the receiver's components are subtracted from the provided date.
    /// ````
    /// let now = Date()
    /// 10.days.before(now)
    /// // The date that is 10 before now.
    /// ````
    /// - Author: Scott Brenner | SBDate
    /// - Parameter date: The date to add `self` to.
    public func before(_ date: some DateRepresentable) -> Date? {
        date.calendar.date(byAdding: -self, to: date.date)
    }
    
    /// Returns the date that will occur once the receiver's components pass after the provided date.
    /// ````
    /// let now = Date()
    /// 10.days.from(now)
    /// // The date that is 10 days from now.
    /// ````
    /// - Author: Scott Brenner | SBDate
    /// - Parameter date: The date to add `self` to.
    public func from(_ date: some DateRepresentable) -> Date? {
        date.calendar.date(byAdding: self, to: date.date)
    }
    
    /// Express a `DateComponents` instance in another time unit you choose.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter component: Time component.
    /// - Parameter calendar:  Context calendar to use.
    /// - Returns: The value of interval expressed in selected `Calendar.Component`.
    public func `in`(_ component: Calendar.Component, of calendar: Calendar? = nil) -> Int? {
        let cal = (calendar ?? Region.default.calendar)
        let start = Date()
        let end = start + self
        return cal.dateComponents([component], from: start, to: end).value(for: component)
    }
    
    /// Express a `DateComponents` instance in a set of time units you choose.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter component: Time component.
    /// - Parameter calendar:  Context calendar to use.
    /// - Returns: A dictionary of extract values.
    public func `in`(_ components: Set<Calendar.Component>, of calendar: Calendar? = nil) -> [Calendar.Component: Int] {
        let cal = (calendar ?? Region.default.calendar)
        let start = Date()
        let end = start + self
        return cal.dateComponents(components, from: start, to: end).componentDictionary
    }
    
    /// - Author: Scott Brenner | SBDate
    public enum Error: LocalizedError {
        case yearIsUndefined
        case yearIsNegative
        
        public var errorDescription: String? {
            switch self {
            case .yearIsUndefined: return "The year is undefined."
            case .yearIsNegative: return "The year is negative."
            }
        }
    }
    
    /// Returns whether or not the year is a leap year.
    /// - Author: Scott Brenner | SBDate
    public func isLeapYear() throws -> Bool {
        guard let year = year
        else { throw Error.yearIsUndefined }
        guard year >= 0
        else { throw Error.yearIsNegative }
        if year % 400 == 0 {
            return true
        }
        else if year % 100 == 0 {
            return false
        }
        else if year % 4 == 0 {
            return true
        }
        return false
    }
    
    /// A dictionary containing only those components that are not `nil`.
    /// - Author: Scott Brenner | SBDate
    public var componentDictionary: [Calendar.Component: Int] {
        var list: [Calendar.Component : Int] = [:]
        DateComponents.allComponents.forEach { component in
            let value = self.value(for: component)
            if value != nil && value != Int(NSDateComponentUndefined) {
                list[component] = value!
            }
        }
        return list
    }
    
    /// Array of components in ascending order.
    /// - Author: Scott Brenner | SBDate
    public static let allComponents: [Calendar.Component] =  [
        .nanosecond,
        .second,
        .minute,
        .hour,
        .day,
        .month,
        .year,
        .yearForWeekOfYear,
        .weekOfYear,
        .weekday,
        .quarter,
        .weekdayOrdinal,
        .weekOfMonth
    ]
    
    /// Negates all values that are not `NSDateComponentUndefined`.
    /// - Author: Scott Brenner | SBDate
    public static prefix func -(rhs: DateComponents) -> DateComponents {
        DateComponents(
            era: rhs.era.map(-),
            year: rhs.year.map(-),
            month: rhs.month.map(-),
            day: rhs.day.map(-),
            hour: rhs.hour.map(-),
            minute: rhs.minute.map(-),
            second: rhs.second.map(-),
            nanosecond: rhs.nanosecond.map(-),
            weekday: rhs.weekday.map(-),
            weekdayOrdinal: rhs.weekdayOrdinal.map(-),
            quarter: rhs.quarter.map(-),
            weekOfMonth: rhs.weekOfMonth.map(-),
            weekOfYear: rhs.weekOfYear.map(-),
            yearForWeekOfYear: rhs.yearForWeekOfYear.map(-)
        )
    }
    
    /// Adds two DateComponents and returns their combined individual components.
    /// - Author: Scott Brenner | SBDate
    public static func +(lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        combine(lhs, rhs: rhs, transform: +)
    }
    
    /// Subtracts two DateComponents and returns the relative difference between them.
    /// - Author: Scott Brenner | SBDate
    public static func -(lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        lhs + (-rhs)
    }
    
    /// Applies the `transform` to both `T` values provided, defaulting either of them if `nil`.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter a: Optional value.
    /// - Parameter b: Optional value.
    /// - Parameter default: The default value to use in the event `a` or `b` are `nil`.
    /// - Parameter transform: The transform to use.
    /// - Returns: The transformed value. If both `T` values are `nil`, returns `nil`.
    private static func bimap<T>(_ a: T?, _ b: T?, default: T, _ transform: (T, T) -> T) -> T? {
        if a == nil && b == nil { return nil }
        return transform(a ?? `default`, b ?? `default`)
    }
    
    /// Combines two date components using the provided `transform` on all values within the components that are not `NSDateComponentUndefined`.
    /// - Author: Scott Brenner | SBDate
    private static func combine(_ lhs: DateComponents, rhs: DateComponents, transform: (Int, Int) -> Int) -> DateComponents {
        var components = DateComponents()
        components.era = bimap(lhs.era, rhs.era, default: 0, transform)
        components.year = bimap(lhs.year, rhs.year, default: 0, transform)
        components.month = bimap(lhs.month, rhs.month, default: 0, transform)
        components.day = bimap(lhs.day, rhs.day, default: 0, transform)
        components.hour = bimap(lhs.hour, rhs.hour, default: 0, transform)
        components.minute = bimap(lhs.minute, rhs.minute, default: 0, transform)
        components.second = bimap(lhs.second, rhs.second, default: 0, transform)
        components.nanosecond = bimap(lhs.nanosecond, rhs.nanosecond, default: 0, transform)
        components.weekday = bimap(lhs.weekday, rhs.weekday, default: 0, transform)
        components.weekdayOrdinal = bimap(lhs.weekdayOrdinal, rhs.weekdayOrdinal, default: 0, transform)
        components.quarter = bimap(lhs.quarter, rhs.quarter, default: 0, transform)
        components.weekOfMonth = bimap(lhs.weekOfMonth, rhs.weekOfMonth, default: 0, transform)
        components.weekOfYear = bimap(lhs.weekOfYear, rhs.weekOfYear, default: 0, transform)
        components.yearForWeekOfYear = bimap(lhs.yearForWeekOfYear, rhs.yearForWeekOfYear, default: 0, transform)
        return components
    }
}
