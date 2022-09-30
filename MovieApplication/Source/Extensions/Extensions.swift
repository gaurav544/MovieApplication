//
//  Extensions.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/29/22.
//

// MARK: Imports
import Foundation
import UIKit

extension Double {
    var formattedAmount: String? {
        return String(format: "%.2f", self as CVarArg)
    }
}

extension String {
    var isEmpty: Bool {
        return self == ""
    }
    
    func formatDateString(from oldDateFormat: String? = Constants.serverDateFormat, to newDateFormat: String) -> String {
        let inputFormatter = DateFormatter()
        var resultString = self
        inputFormatter.dateFormat = oldDateFormat
        if let showDate = inputFormatter.date(from: self) {
            inputFormatter.dateFormat = newDateFormat
            resultString = inputFormatter.string(from: showDate)
        }
        
        return resultString
    }
}

extension UIColor {
    static let navigationBarColor = UIColor(red: 75.0/255.0, green: 151.0/255.0, blue: 246.0/255.0, alpha: 1.0)
}
