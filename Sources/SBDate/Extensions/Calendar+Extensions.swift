import Foundation

extension Calendar {
    
    /// Returns the difference between two dates.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter components: Which components to compare.
    /// - Parameter start: The starting date.
    /// - Parameter end: The ending date.
    /// - Returns: The result of calculating the difference from start to end.
    public func dateComponents(_ components: Set<Calendar.Component>, from start: DateRepresentable, to end: DateRepresentable) -> DateComponents {
        dateComponents(components, from: start.date, to: end.date)
    }
}
