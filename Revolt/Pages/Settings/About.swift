//
//  About.swift
//  Revolt
//
//  Created by Angelo on 31/10/2023.
//

import Foundation
import SwiftUI

struct About: View {
    @EnvironmentObject var viewState: ViewState

    var body: some View {
        VStack {
            Image("wide")

            Text("Revolt on IOS")

            Text("0.0.1")
                .font(.caption)

            Spacer()
                .frame(height: 30)

            Text("Brought to you with ❤️ by the Revolt team.")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewState.theme.background.color)
    }
}

struct About_Preview: PreviewProvider {
    static var previews: some View {
        About()
    }
}