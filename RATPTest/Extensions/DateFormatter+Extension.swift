//
//  DateFormatter+Extension.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 11/02/2024.
//

import Foundation

extension DateFormatter {
    static func shortFormatter(withLocale locale: Locale) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = locale
        return dateFormatter
    }
}
