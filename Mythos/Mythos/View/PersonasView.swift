//
//  PersonasView.swift
//  Mythos
//
//  Created by Narely Lima on 10/10/23.
//

import SwiftUI

struct PersonasView: View {
    
    @State var namePerson: String
    @State var lifePerson: String

    @State var cards: [Card]
    @State var isTapped: Bool = false
    
    let namePerson: String
    let lifePerson: Int

    var body: some View {
        VStack {
            Text(namePerson.description)
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30)
                .overlay {
                    Text("\(lifePerson)")
                }
            HStack(spacing: -50) {
                Spacer()
                ForEach(cards, id: \.id) {
                    card in
                    BackCardView()
                        .frame(maxHeight: 150)
                }
                .transition(.move(edge: .top))
                Spacer()
            }
        }
    }
}

struct PersonasView_Previews: PreviewProvider {
    static var previews: some View {
        let namePerson: String = "Sarinha"
        let lifePerson: String = "30"
        @State var cards: [Card] = [Card(id: 1234, name: "Teste1", type: .action, damage: 5),Card(id: 34343, name: "Teste2", type: .action, damage: 2), Card(id: 243342, name: "Teste3", type: .reaction, damage: 1)]
        PersonasView(namePerson: namePerson, lifePerson: lifePerson, cards: cards)
    }
}

protocol MaybeGameViewPersonaViewDelegate {
    func updatePersonaViewLife(with life: String)
}
