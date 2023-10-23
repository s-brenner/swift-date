import Foundation

extension DateInterval: RegionRepresentable {
    
    /// - Author: Scott Brenner | SBDate
    public var region: Region { start.region }
}


extension DateInterval {
    
    /// Includes only the nanoseconds, seconds, minutes, hours, and days.
    /// - Author: Scott Brenner | SBDate
    public var dateComponents: DateComponents {
        start.calendar.dateComponents([.nanosecond, .second, .minute, .hour, .day], from: start, to: end)
    }
    
    /// - Author: Scott Brenner | SBDate
    public init(start: DateRepresentable, end: DateRepresentable) {
        self.init(start: start.date, end: end.date)
    }
    
    /// - Author: Scott Brenner | SBDate
    public init(start: DateRepresentable, duration: TimeInterval) {
        self.init(start: start.date, duration: duration)
    }
    
    /// - Author: Scott Brenner | SBDate
    public init(start: DateRepresentable, duration: DateComponents) {
        self.init(start: start.date, end: (start + duration).date)
    }
}
