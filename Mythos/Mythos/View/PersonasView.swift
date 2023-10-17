//
//  PersonasView.swift
//  Mythos
//
//  Created by Narely Lima on 10/10/23.
//

import SwiftUI

struct PersonasView: View {

    @State var cards: [Card]

    
    let namePerson: String
    let lifePerson: Int
    var index: Int
    
    var body: some View {
        if index == 1 {
            VStack {
                VStack {
                    Text(namePerson.description)
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Text("\(lifePerson)")
                        }
                }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .top))
                    .rotation3DEffect(.degrees(10), axis: (x:-40,y:6,z:0))

                    Spacer()
                }
                .frame(maxWidth: 110.51, maxHeight: 177.4)
                .rotation3DEffect(Angle(degrees: 50), axis: (x:-20, y:40, z:-10))
            }
        } else
        if index == 3 {
            VStack {
                VStack {
                    Text(namePerson.description)
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Text("\(lifePerson)")
                        }
                }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .top))
                    .rotation3DEffect(.degrees(-10), axis: (x:40,y:-6,z:0))


                    Spacer()
                }
                .frame(maxWidth: 110.51, maxHeight: 177.4)
                .rotation3DEffect(Angle(degrees: -50), axis: (x:20, y:40, z:-10))
            }
        }
        if index == 2 {

            VStack(spacing: 0) {
                Text(namePerson.description)
                Circle()
                    .foregroundColor(.yellow)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Text("\(lifePerson)")
                    }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .top))
                    Spacer()
                }
                .frame(maxWidth: 110.51, maxHeight: 177.4)
            }
        }
    }
}

struct PersonasView_Previews: PreviewProvider {
    static var previews: some View {
        let namePerson: String = "Sarinha"
        let lifePerson = 30
        let index = 2
        @State var cards: [Card] = [Card(id: 1234, name: "Teste1", type: .action, damage: 5),Card(id: 34343, name: "Teste2", type: .action, damage: 2), Card(id: 243342, name: "Teste3", type: .reaction, damage: 1)]
        PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index)
    }
}

protocol MaybeGameViewPersonaViewDelegate {
    func updatePersonaViewLife(with life: String)
}
