//
//  ValidationExtensions.swift
//  fitMate
//
//  Created by Emre Simsek on 26.04.2025.
//
import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+=\\[\\]{}|;:'\",.<>?/`~\\\\-]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }

    func isNotEmpty() -> Bool {
        return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func isValidName() -> Bool {
        return self.count >= 2
    }
}
