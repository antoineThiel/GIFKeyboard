//
//  ErrorUtils.swift
//  GIFKeyboard
//
//  Created by Antoine Thiel on 05/03/2022.
//

import Foundation

class ErrorUtils {
    
    enum Code: Int {
        case gifNotFound = 1
    }
    
    private static var errors = ErrorUtils.generateErrors()
    
    private class func generateErrors() -> [Code: String] {
        return [
            Code.gifNotFound: "Gif not found",
        ]
    }

    public class func buildError(code: Code) -> Error {
        return NSError(domain: "org.cocoapods.GIFKeyboard", code: code.rawValue, userInfo: [
            NSLocalizedDescriptionKey: self.errors[code] ?? ""
        ])
    }
    
}
