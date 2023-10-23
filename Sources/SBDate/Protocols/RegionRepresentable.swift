import Foundation

/// - Author: Scott Brenner | SBDate
public protocol RegionRepresentable {
    
    /// Associated region.
    /// - Author: Scott Brenner | SBDate
    var region: Region { get }
}


extension RegionRepresentable {
    
    /// Associated calendar.
    /// - Author: Scott Brenner | SBDate
    public var calendar: Calendar { region.calendar }
    
    var sharedDateFormatter: DateFormatter { .shared(dateStyle: .full, timeStyle: .full, region: region) }
}
