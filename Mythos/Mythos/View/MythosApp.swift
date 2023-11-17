//
//  MythosApp.swift
//  Mythos
//
//  Created by Narely Lima on 04/09/23.
//

import SwiftUI

@main
struct MythosApp: App {
    @StateObject private var viewModel = GKPlayerViewModel()

    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(vm: viewModel)
                    .overlay {
                        if !viewModel.isAutenticated {
                           LodingView()
                        }
                    }
            }
        }
    }
}
