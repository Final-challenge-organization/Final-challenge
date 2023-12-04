//
//  CardRepresentabl.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

import SwiftUI
import CoreHaptics

struct CardRepresentable: View {

    @EnvironmentObject var tutorialModel: TutorialModel
    @State private var engine: CHHapticEngine?

    var isYourTurn : Bool?
    var isReaction: Bool?
    var card: Card
    var isPresentedTutorial: Bool = false
    var onTap: () -> Void

    var body: some View {
        switch card.type {
        case .action(.damage):
            CardRepresentableCustom(imageName: "action", card: card)
                .overlay(content: {
                    if !isPresentedTutorial {
                        (isYourTurn ?? true && !(isReaction ?? false)) ? Color.clear : Color.gray.opacity(0.5)
                    } else {
                        if tutorialModel.matchNumberTutorial == 1 {
                            isYourTurn! ? Color.clear : Color.gray.opacity(0.5)
                        } else {
                            isYourTurn! ? Color.gray.opacity(0.5) : Color.clear
                        }
                    }
                })
                .onTapGesture {
                    if !isPresentedTutorial {
                        if (isYourTurn ?? true && !(isReaction ?? false)) {
                            onTap()
                            prepareHaptics()
                            complexSuccess()
                        }
                    } else {
                        if tutorialModel.matchNumberTutorial == 1 {
                            if (isYourTurn ?? true && !(isReaction ?? false)) {
                                onTap()
                                prepareHaptics()
                                complexSuccess()
                            }
                        }
                    }
                }
        case .action(.block):
            CardRepresentableCustom(imageName: "action", card: card)
                .overlay(content: {
                    if !isPresentedTutorial {
                        ((isYourTurn ?? true && !(isReaction ?? false)) ? Color.clear : Color.gray.opacity(0.5))
                    } else {
                        if tutorialModel.matchNumberTutorial == 2 {
                            isYourTurn! ? Color.clear : Color.gray.opacity(0.5)
                        } else {
                            isYourTurn! ? Color.gray.opacity(0.5) : Color.clear
                        }
                    }
                })
                .onTapGesture {
                    if !isPresentedTutorial {
                        if (isYourTurn ?? true && !(isReaction ?? false)) {
                            onTap()
                            prepareHaptics()
                            complexSuccess()
                        }
                    } else {
                        if tutorialModel.matchNumberTutorial == 2 {
                            if (isYourTurn ?? true && !(isReaction ?? false)) {
                                onTap()
                                prepareHaptics()
                                complexSuccess()
                            }
                        }
                    }
                }
        case .reaction:
            CardRepresentableCustom(imageName: "reaction", card: card)
                .overlay(content: {
                    if !isPresentedTutorial {
                        (isYourTurn ?? true || isReaction ?? true) ? Color.clear : Color.gray.opacity(0.5)
                    } else {
                        if tutorialModel.matchNumberTutorial == 3 {
                            isYourTurn! ? Color.clear : Color.gray.opacity(0.5)
                        } else {
                            isYourTurn! ? Color.gray.opacity(0.5) : Color.clear
                        }
                    }
                })
                .onTapGesture {
                    if !isPresentedTutorial {
                        if (isYourTurn ?? true || !(isReaction ?? true)) {
                            onTap()
                            prepareHaptics()
                            complexSuccess()
                        }
                    } else {
                        if tutorialModel.matchNumberTutorial == 3 {
                            if (isYourTurn ?? true || !(isReaction ?? true)) {
                                onTap()
                                prepareHaptics()
                                complexSuccess()
                            }
                        }
                    }
                }
        }
    }

    func simpleTouch() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 10)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)

            try player?.start(atTime: 0)
            print("Playing pattern...")
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

}

struct CardRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        let arr: [Card] =  [
            Card(id: 0, name: "Sandalias Aladas", imageName: "sandaliasAladas", type: .action(.damage), damage: 0, effect: "Se defende parcialmente de um dano de 3 pontos", description: "“Võe para se esquivar de pequenos ataques. Com as sandálias aladas de Perseus, você é capaz de se defender de pequenos danos.”"),
            Card(id: 1, name: "Escudo de Justica", imageName: "escudoDeJustica", type: .reaction, damage: 0, effect: "Defesa total", description: "“Aquele que possuir o escudo de Atenas, consegue se defender totalmente de um ataque recebido. Use-o com sabedoria.”"),
            Card(id: 2, name: "Olhar de Ciclope", imageName: "olharDeCiclope", type: .reaction, damage: 0, effect: "Causa 5 pontos de dano ao próximo jogador", description: "“A força descomunal de um Ciclope é capaz de fazer gigantes estragos. Força descomunal é a resposta para a vitória.”"),
            Card(id: 3, name: "Martelada de Hefestos", imageName: "marteladaDeHefestos", type: .reaction, damage: 0, effect: "Causa 3 pontos de dano ao próximo jogador", description: "“Armas fortes são de grande auxílio na hora da batalha. Com a capacidade de forjar e manipular metais divinamente, Hefesto pode conceder uma arma.”"),
            Card(id: 4, name: "Manipulação de Fluxo", imageName: "manipulacaoDeFluxo", type: .action(.block), damage: 0, effect: "Altera a ordem do jogo", description: "“Inverter a ordem das coisas pode influenciar o destino de todos os jogadores! Utilize o dom de Cronos para controlar e alterar o fluxo do tempo.”"),
        ]

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(arr, id: \.id) { card in
                        CardRepresentable(isYourTurn: true, isReaction: false, card: card, isPresentedTutorial: false) {
                            print()
                        }
                        .frame(width: 744/5, height: 1039/5)
                    }
                }
            }

    }
}

