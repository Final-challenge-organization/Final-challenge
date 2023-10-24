//
//  PersonasView.swift
//  Mythos
//
//  Created by Narely Lima on 10/10/23.
//

import SwiftUI

struct PersonasView: View {

    let cards: [Card]
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
        if index == 0 {
            VStack(spacing: 0) {
                VStack {

                    Text(namePerson.description)
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Text("\(lifePerson)")
                        }
                }
                .offset(x: 0, y: -75)

                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 55, height: 115)
                    }
                    Spacer()
                }

            }
        }
        if index == 2 {
            VStack(spacing: 0) {
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
                .offset(y: 50)
                .frame(maxWidth: 110.51, maxHeight: 177.4)
                VStack{
                    Text(namePerson.description)
                    Circle()

                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Text("\(lifePerson)")
                        }
                }
                    .offset(y: 40)
            }
        }
        if index == 5 {
            VStack(spacing: 0) {
                VStack {

                    Text(namePerson.description)
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Text("\(lifePerson)")
                        }
                }
                .offset(x: 0, y: -75)

                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 55, height: 115)
                    }
                    Spacer()
                }

            }
            .foregroundColor(.clear)
        }
    }
}

struct PersonasView_Previews: PreviewProvider {
    static var previews: some View {
        let namePerson: String = "Sarinha"
        let lifePerson = 30
        let index = 2
        @State var cards: [Card] = [
            Card(id: 1234,
                 name: "Teste1",
                 imageName: "escudoDeJustica",
                 type: .action(.damage),
                 damage: 5,
                 effect: "TESTANDO",
                 description: "testando"),
            Card(id: 34343,
                 name: "Teste2",
                 imageName: "escudoDeJustica",
                 type: .action(.damage),
                 damage: 2,
                 effect: "TESTANDO",
                 description: "testando"),
            Card(id: 243342,
                 name: "Teste3",
                 imageName: "escudoDeJustica",
                 type: .reaction,
                 damage: 1,
                 effect: "TESTANDO",
                 description: "testando")
        ]
        PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index)
    }
}

protocol MaybeGameViewPersonaViewDelegate {
    func updatePersonaViewLife(with life: String)
}
