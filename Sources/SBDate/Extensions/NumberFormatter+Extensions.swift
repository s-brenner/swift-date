import Foundation

extension NumberFormatter {
    
    /// Return the local thread shared number formatter for a given number style configured for the given locale.
    /// - Parameter locale: Locale of the returned formatter.
    static func shared(
        numberStyle: NumberFormatter.Style,
        locale: Locale = Region.default.locale
    ) -> NumberFormatter {
        let name = "SBDate.\(String(describing: NumberFormatter.self)).numberStyle=\(numberStyle)"
        let formatter: NumberFormatter = threadSharedObject(key: name) {
            let formatter = NumberFormatter()
            formatter.numberStyle = numberStyle
            return formatter
        }
        formatter.locale = locale
        return formatter
    }
}
