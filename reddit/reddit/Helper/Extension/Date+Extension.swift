//
//  Date+Extension.swift
//  reddit
//
//  Created by Juan Martin Contreras on 12/01/2021.
//

import Foundation

extension Date {

    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
}
