//
//  MaybeGameView.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

//
//  MaybeGameView.swift
//  POC-websocketClientSide
//
//  Created by Luiz Sena on 25/09/23.
//

import SwiftUI
import CoreHaptics

struct MaybeGameView: View {
    @ObservedObject var websocket: WebSocket
    @State var cardSelected: Card? = nil
    @State var isTapped: Bool = false
    @State private var engine: CHHapticEngine?
    
    @State var isPresentedGame: Bool

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack{
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            ZStack {
                ForEach(Array(websocket.connectedPlayers.enumerated()), id: \.element.id) { index, player in
                    if websocket.myPlayerReference == player {
                        generatePlayerLayout(for: index, players: websocket.connectedPlayers)
                    }
                }
                VStack{
                    Spacer()
                    ProgressView("Sua Vida:", value: Double(websocket.myPlayerReference.life), total: 30)
                        .progressViewStyle(GaugeProgressStyle())
                        .frame(width: 90, height: 90)


                    ZStack {
                        Image("deck_comprar")
                            .offset(x: -250, y: 10)
                        HStack(spacing: -50) {
                            Spacer()
                            ForEach(Array(websocket.myPlayerReference.handCards.enumerated()), id: \.element.id) {
                                (index , card) in
                                CardRepresentable(
                                    isYourTurn: websocket.myPlayerReference.isYourTurn,
                                    isReaction: websocket.myPlayerReference.isReaction,
                                    card: card) {
                                        self.cardSelected = card
                                        withAnimation {
                                            self.isTapped.toggle()
                                        }
                                    }
                                    .frame(maxHeight: 150)
                                    .onAppear(perform: prepareHaptics)
                                    .onTapGesture(perform: complexSuccess)
                                    .scaledToFit()
                                    .offset(y: (index == 0 || index == 2) ? 0 : -15)
                                    .offset(y: cardSelected == card && isTapped ? -55 : 0)
                                    .rotationEffect(Angle(degrees: index == 0 ? -5 : (index == 2 ? 5 : 0)))
                                    .zIndex(index == 2 ? 1 : 0) // Coloca a carta do meio na frente

                            }
                            .transition(.move(edge: .top))
                            Spacer()
                        }
                        .animation(.easeInOut, value: websocket.myPlayerReference.handCards.count)
                        .offset(y: 90)
                        .ignoresSafeArea()

                        if websocket.myPlayerReference.isYourTurn {
                            Button {
                                websocket.sendCard(with: cardSelected)
                                self.isTapped = false
                            } label: {
                                Image("button_descarte")
                                    .frame(maxWidth: 40, maxHeight: 40)
                                    .scaledToFit()
                            }
                            .offset(x: 250, y: 10)
                            .disabled(!isTapped)
                        }
                    }
                    !isPresentedGame ? buttonDismiss : nil
                }
                .onChange(of: websocket.isGameOver) { newValue in
                    print("O jogador \(websocket.myPlayerReference.name) perdeu a partida")
                    isPresentedGame = false
                    UserDefaults.standard.set(isPresentedGame, forKey: "isPresentedGame")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

    func generatePlayerLayout(for index: Int, players: [PlayerClient]) -> some View {

        let firstPlayerIndex = (index) % players.count
        let secondPlayerIndex = (index + 1) % players.count
        let thirdPlayerIndex = (index + 2) % players.count
        let lastPlayerIndex = (index + 3) % players.count

        var firstPlayer = players[firstPlayerIndex]
        var secondPlayer = players[secondPlayerIndex]
        var thirdPlayer = players[thirdPlayerIndex]
        var lastPlayer = players[lastPlayerIndex]

        var viewPersonas: some View {
            VStack {
                (players.count < 3) ? nil : PersonasView(namePerson: thirdPlayer.name, lifePerson: thirdPlayer.life)
                HStack {
                    (players.count < 2) ? nil : PersonasView(namePerson: secondPlayer.name, lifePerson: secondPlayer.life)
                    Spacer()
                    (players.count < 4) ? nil : PersonasView(namePerson: lastPlayer.name, lifePerson: lastPlayer.life)
                        .padding(.trailing, 60)
                }
                PersonasView(namePerson: firstPlayer.name, lifePerson: firstPlayer.life)
            }
        }
        return viewPersonas
    }

    var buttonDismiss: some View {
        Button("Tela Inicial") {
            dismiss()
        }
    }

}

struct MaybeGameView_Previews: PreviewProvider {
    static var previews: some View {
        MaybeGameView(websocket: WebSocket(), isPresentedGame: true)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.green.gradient
    var strokeWidth = 8.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        let number = (configuration.fractionCompleted ?? 0) * 30

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .overlay {
                    VStack {
                        Text("Sua vida:")
                            .font(Font.title3.bold())
                            .foregroundColor(.white)
                        Text(Int(number).description)
                            .font(Font.title3.bold())
                            .foregroundColor(.white)
                    }
                }
        }
    }
}

