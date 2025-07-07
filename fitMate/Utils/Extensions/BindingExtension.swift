//
//  BindingExtension.swift
//  fitMate
//
//  Created by Emre Simsek on 13.06.2025.
//
import SwiftUI

extension Binding where Value == String? {
    func unwrap(default defaultValue: String) -> Binding<String> {
        Binding<String>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0.isEmpty ? nil : $0 }
        )
    }
}
