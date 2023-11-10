//
//  LodingView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 08/11/23.
//

import SwiftUI

struct LodingView: View {

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.thinMaterial)
                .ignoresSafeArea()
            ProgressView()
            .progressViewStyle(.circular)
        }
    }
}

struct LodingView_Previews: PreviewProvider {
    static var previews: some View {
        LodingView()
    }
}
