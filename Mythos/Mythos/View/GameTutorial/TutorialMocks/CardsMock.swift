//
//  CardsMock.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import Foundation
import SwiftUI

var deckMock = [
    Card(uuid: UUID(), id: 1, name: "Flecha Encantada",
         imageName: "flechaEncantada", type: .action(.block),
         damage: 0, effect: "Bloqueia o próximo jogador",
         description: "“Quem é acertado por esta flecha encantadas de Artemis  fica impossibilitado de jogar por causa do sono da lua.”",
         descTutorial: """
        A carta é de Efeito
        Com essa carta, você impede que o Jogador 1 jogue esta rodada.
        """),
    Card(uuid: UUID(), id: 2, name: "Escudo de Justiça",
         imageName: "escudoDeJustica", type: .reaction,
         damage: 30, effect: "Defesa total", description: "“Aquele que possuir o escudo de Atenas, consegue se defender totalmente de um ataque recebido. Use-o com sabedoria.”",
         descTutorial: """
        A carta é de Defesa
        Com esta carta, você se defende completamente de qualquer ataque que fizerem a você.
        """),
    Card(uuid: UUID(), id: 3, name: "Olhar de Ciclope",
         imageName: "olharDeCiclope", type: .action(.damage),
         damage: 5, effect: "Causa 5 pontos de dano ao próximo jogador",
         description: "“A força descomunal de um Ciclope é capaz de fazer gigantes estragos. Força descomunal é a resposta para a vitória.”",
         descTutorial: """
         A carta é de Ataque
         Com esta carta, você ataca o jogador 1 com 5 pontos de dano. No entanto, ele poderá se defender!
       """),
    Card(uuid: UUID(), id: 4, name: "Martelada de Hefestos",
         imageName: "marteladaDeHefestos", type: .action(.damage),
         damage: 3, effect: "Causa 3 pontos de dano ao próximo jogador",
         description: "“Armas fortes são de grande auxílio na hora da batalha. Com a capacidade de forjar e manipular metais divinamente, Hefesto pode conceder uma arma.”",
         descTutorial: """
        A carta é de Ataque
        Com esta carta, você ataca o jogador 1 com 3 pontos de dano. No entanto, ele poderá se defender!
        """)
]
