//
//  UserGameView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 08/11/23.
//

import SwiftUI
import GameKit

struct UserGameView: View {

//    let localPlayer = GKLocalPlayer.local
    @ObservedObject var vm: GKPlayerViewModel

    var body: some View {
        
                ZStack{
                    Rectangle()
                            .fill(Color.yellow)
                           .frame(width: 128, height: 58)
                           .overlay(
                            Text(vm.username)
                                .foregroundColor(.black)
                           )
                    Image("profile")
                        .resizable()
                        .frame(width: 65, height: 58)
                        .padding(.trailing, 190)

                }
    }
}

struct UserGameView_Previews: PreviewProvider {
    static var previews: some View {
        UserGameView(vm: GKPlayerViewModel())
    }
}
