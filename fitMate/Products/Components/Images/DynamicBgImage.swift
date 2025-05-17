//
//  DynamicBgImage.swift
//  fitMate
//
//  Created by Emre Simsek on 15.04.2025.
//

import SwiftUI

struct DynamicBgImage: View {
    var body: some View {
        Image(.bg)
            .resizable()
            .opacity(0.7)
            .ignoresSafeArea()
    }
}
