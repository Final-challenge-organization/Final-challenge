//
//  UserGameView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 08/11/23.
//

import SwiftUI
import GameKit

struct UserGameView: View {

    @ObservedObject var vm: GKPlayerViewModel

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Image(uiImage: vm.imagePlayer)
                    .resizable()
                    .frame(width: 58, height: 58)
                    .scaledToFit()
                Rectangle()
                    .fill(Color(red: 252/255, green: 170/255, blue: 0/255))
                    .frame(width: 168, height: 58)
                    .overlay(
                        Text(vm.username)
                            .padding([.leading, .trailing])
                            .font(MyCustomFonts.CeasarDressingRegular.font)
                            .foregroundColor(Color.init(red: 60/255, green: 25/255, blue: 1/255))
                            .minimumScaleFactor(0.01)
                            .lineLimit(0)
                    )
            }
        }
        .border(Color(red: 84/255, green: 46/255, blue: 15/255), width: 2)
    }
}

struct UserGameView_Previews: PreviewProvider {
    static var previews: some View {
        UserGameView(vm: GKPlayerViewModel())
    }
}
