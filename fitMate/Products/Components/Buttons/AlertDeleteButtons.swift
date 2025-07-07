//
//  AlertDeleteButtons.swift
//  fitMate
//
//  Created by Emre Simsek on 15.06.2025.
//

import SwiftUI

struct AlertDeleteButtons: View {
    var onDelete: () async -> Void
    var body: some View {
        Button(LocaleKeys.Button.delete.localized, role: .destructive) {
            Task { await onDelete() }
        }
        Button(LocaleKeys.Button.cancel.localized, role: .cancel) {}
    }
}

#Preview {
    AlertDeleteButtons {}
}
