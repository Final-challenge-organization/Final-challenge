//
//  CardRepresentabl.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

import SwiftUI
import CoreHaptics

struct CardRepresentable: View {

    @State private var engine: CHHapticEngine?

    var isYourTurn : Bool
    var isReaction: Bool
    var card: Card
    var onTap: () -> Void

    var body: some View {
        switch card.type {
        case .action(.damage):
            actionCard
                .overlay(content: {
                    (isYourTurn && !isReaction) ? Color.clear : Color.gray.opacity(0.5)
                })
                .onTapGesture {
                    if (isYourTurn && !isReaction) {
                        onTap()
                        prepareHaptics()
                        complexSuccess()
                    }
                }
        case .action(.block):
            actionCard
                .overlay(content: {
                    (isYourTurn && !isReaction) ? Color.clear : Color.gray.opacity(0.5)
                })
                .onTapGesture {
                    if (isYourTurn && !isReaction) {
                        onTap()
                        prepareHaptics()
                        complexSuccess()
                    }
                }
        case .reaction:
            reactionCard
                .overlay(content: {
                    (isYourTurn || isReaction) ? Color.clear : Color.gray.opacity(0.5)
                })
                .onTapGesture {
                    if (isYourTurn || isReaction) {
                        onTap()
                        prepareHaptics()
                        complexSuccess()
                    }
                }
        }
    }


    var actionCard: some View {
        GeometryReader { geo in
            Image("action")
                .resizable()
                .overlay {
                    ZStack {
                        VStack {
                            Text(card.name)
                                .font(MyCustomFonts.CeasarDressingRegular.font)
                                .foregroundColor(Color("cardTitleColor"))
                                .minimumScaleFactor(0.01)
                                .lineLimit(0)
                                .padding([.leading, .trailing], geo.size.width/8)
                                .padding(.top, geo.size.height/40)
                                Spacer()
                        }
                        VStack {
                            Image(card.imageName)
                                .resizable()
                                .frame(width: geo.size.width/1.5, height:  geo.size.width/1.5)
                                .scaledToFit()
                                .padding(.bottom, geo.size.height/3.5)
                        }
                        VStack(spacing: 0) {
                            Spacer()
                            Text(card.effect)
                                .font(MyCustomFonts.CabinBold.font)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .padding([.leading, .trailing], geo.size.width/8)
                                .frame(width: geo.size.width, height: geo.size.height/10)
                            Text(card.description)
                                .font(MyCustomFonts.CabinMediumItalic.font)
                                .minimumScaleFactor(0.01)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("cardDescriptionColor"))
                                .padding([.leading, .trailing])
                                .frame(width: geo.size.width, height: geo.size.height/6.2)
                                .padding(.bottom, geo.size.height/14)
                        }
                    }
                }
        }
    }
    var reactionCard: some View {
        GeometryReader { geo in
            Image("reaction")
                .resizable()
                .overlay {
                    ZStack {
                        VStack {
                            Text(card.name)
                                .font(MyCustomFonts.CeasarDressingRegular.font)
                                .foregroundColor(Color("cardTitleColor"))
                                .minimumScaleFactor(0.01)
                                .lineLimit(0)
                                .padding([.leading, .trailing], geo.size.width/8)
                                .padding(.top, geo.size.height/40)
                                Spacer()
                        }
                        VStack {
                            Image(card.imageName)
                                .resizable()
                                .frame(width: geo.size.width/1.5, height:  geo.size.width/1.5)
                                .scaledToFit()
                                .padding(.bottom, geo.size.height/3.5)
                        }
                        VStack(spacing: 0) {
                            Spacer()
                            Text(card.effect)
                                .font(MyCustomFonts.CabinBold.font)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .padding([.leading, .trailing], geo.size.width/8)
                                .frame(width: geo.size.width, height: geo.size.height/10)
                            Text(card.description)
                                .font(MyCustomFonts.CabinMediumItalic.font)
                                .minimumScaleFactor(0.01)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("cardDescriptionColor"))
                                .padding([.leading, .trailing])
                                .frame(width: geo.size.width, height: geo.size.height/6.2)
                                .padding(.bottom, geo.size.height/14)
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
                        CardRepresentable(isYourTurn: true, isReaction: false, card: card) {
                            print()
                        }
                        .frame(width: 744/5, height: 1039/5)
                    }
                }
            }

    }
}

