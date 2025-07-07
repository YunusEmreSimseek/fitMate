//
//  SplashView.swift
//  fitMate
//
//  Created by Emre Simsek on 20.06.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            DynamicBgImage()
            
//            VStack {
//                Spacer()
//                ProgressView("Loading...")
//                    .progressViewStyle(.circular)
//                    .allPadding()
//                Spacer()
//            }
        }.modifier(CenterLoadingViewModifier(isLoading: true))
    }
}

#Preview {
    SplashView()
}
