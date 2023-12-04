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
         description: "“Quem é acertado por esta flecha encantada de Artemis fica impossibilitado de jogar por causa do sono da lua.”"),
    Card(uuid: UUID(), id: 2, name: "Escudo de Justiça",
         imageName: "escudoDeJustica", type: .reaction,
         damage: 30, effect: "Defesa total", description: "“Aquele que possuir o escudo de Atenas, consegue se defender totalmente de um ataque recebido. Use-o com sabedoria.”"),
    Card(uuid: UUID(), id: 3, name: "Olhar de Ciclope",
         imageName: "olharDeCiclope", type: .action(.damage),
         damage: 5, effect: "Causa 5 pontos de dano ao próximo jogador",
         description: "“A força descomunal de um Ciclope é capaz de fazer gigantes estragos. Força descomunal é a resposta para a vitória.”"),
    Card(uuid: UUID(), id: 4, name: "Martelada de Hefestos",
         imageName: "marteladaDeHefestos", type: .action(.damage),
         damage: 3, effect: "Causa 3 pontos de dano ao próximo jogador",
         description: "“Armas fortes são de grande auxílio na hora da batalha. Com a capacidade de forjar e manipular metais divinamente, Hefesto pode conceder uma arma.”")
]
