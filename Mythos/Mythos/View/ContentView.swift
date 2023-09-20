//
//  ContentView.swift
//  Mythos
//
//  Created by Narely Lima on 04/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            buttonInitial
        }

    }

    var buttonInitial: some View {
        NavigationLink {
            ClientSideView()
            .ignoresSafeArea()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 100, height: 50)
                    .foregroundColor(.black)
                Text("Iniciar")
                    .foregroundColor(.white)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
