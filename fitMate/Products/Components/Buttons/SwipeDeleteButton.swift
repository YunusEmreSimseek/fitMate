//
//  SwipeDeleteButton.swift
//  fitMate
//
//  Created by Emre Simsek on 15.06.2025.
//

import SwiftUI

struct SwipeDeleteButton: View {
    var onTap: () -> Void
    var body: some View {
        Button { onTap() }
            label: { ConstComponents.deleteLabel }.tint(.red)
    }
}

#Preview {
    SwipeDeleteButton {}
}
