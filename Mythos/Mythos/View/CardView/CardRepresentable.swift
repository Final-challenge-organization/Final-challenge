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

        GeometryReader { geo in
            if card.type == .action {
                Image("actionCard")
                    .resizable()
                    .scaledToFit()
                    .overlay(content: {
                        VStack {
                            Spacer()
                            Text("Cause: \(card.damage)")
                                .font(MyCustomFonts.ConvergenceRegular.font)
                                .foregroundColor(.white)
                                .scaledToFill()
                                .padding(.bottom, 25)
                        }
                    })
                    .overlay {
                        (isYourTurn && !isReaction) ? Color.clear : Color.gray.opacity(0.5)
                    }
                    .onTapGesture {
                        if (isYourTurn && !isReaction) {
                            onTap()
                            prepareHaptics()
                            complexSuccess()
//                            simpleTouch()
                        }
                    }
            }
            if card.type == .reaction {
                Image("reactionCard")
                    .resizable()
                    .scaledToFit()
                    .overlay(content: {
                        VStack {
                            Spacer()
                            Text("Defenda: \(card.damage)")
                                .font(MyCustomFonts.ConvergenceRegular.font)
                                .foregroundColor(.white)
                                .scaledToFill()
                                .padding(.bottom, 25)
                        }
                    })
                    .overlay {
                        (isYourTurn || isReaction) ? Color.clear : Color.gray.opacity(0.5)
                    }
                    .onTapGesture {
                        if (isYourTurn || isReaction) {
                            onTap()
                            prepareHaptics()
                            complexSuccess()
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
        VStack {
            CardRepresentable(
                isYourTurn: true,
                isReaction: false,
                card: Card(id: 0, name: "", type: .action, damage: 10)
            ) {
                print("haptic...")
            }
            .frame(width: 200, height: 250)
//            CardRepresentable(isYourTurn: true, isReaction: true, card: Card(id: 0, name: "", type: .reaction, damage: 10), onTap: {})
//                .frame(width: 200, height: 250)
        }
    }
}

