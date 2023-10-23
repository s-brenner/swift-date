import Foundation

extension Int {
    
    /// Create a `DateComponents` with `self` value set as nanoseconds.
    /// - Author: Scott Brenner | SBSwiftDate
    public var nanoseconds: DateComponents { toDateComponents(type: .nanosecond) }
    
    /// Create a `DateComponents` with `self` value set as seconds.
    /// - Author: Scott Brenner | SBSwiftDate
    public var seconds: DateComponents { toDateComponents(type: .second) }
    
    /// Create a `DateComponents` with `self` value set as minutes.
    /// - Author: Scott Brenner | SBSwiftDate
    public var minutes: DateComponents { toDateComponents(type: .minute) }
    
    /// Create a `DateComponents` with `self` value set as hours.
    /// - Author: Scott Brenner | SBSwiftDate
    public var hours: DateComponents { toDateComponents(type: .hour) }
    
    /// Create a `DateComponents` with `self` value set as days.
    /// - Author: Scott Brenner | SBSwiftDate
    public var days: DateComponents { toDateComponents(type: .day) }
    
    /// Create a `DateComponents` with `self` value set as weeks.
    /// - Author: Scott Brenner | SBSwiftDate
    public var weeks: DateComponents { toDateComponents(type: .weekOfYear) }
    
    /// Create a `DateComponents` with `self` value set as months.
    /// - Author: Scott Brenner | SBSwiftDate
    public var months: DateComponents { toDateComponents(type: .month) }
    
    /// Create a `DateComponents` with `self` value set as years.
    /// - Author: Scott Brenner | SBSwiftDate
    public var years: DateComponents { toDateComponents(type: .year) }
    
    /// Create a `DateComponents` with `self` value set as quarters.
    /// - Author: Scott Brenner | SBSwiftDate
    public var quarters: DateComponents { toDateComponents(type: .quarter) }
    
    /// Private transformation function.
    /// - Author: Scott Brenner | SBSwiftDate
    /// - Parameter type: component to use
    /// - Returns: Return `DateComponents` where given `Calendar.Component` has `self` as value.
    private func toDateComponents(type: Calendar.Component) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.setValue(self, for: type)
        return dateComponents
    }
}
