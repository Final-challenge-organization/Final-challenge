//
//  ButtonPlayView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI
import CoreMotion

struct PlayButtonView: View {
    @State var motion: CMDeviceMotion? = nil
    let motionManager = CMMotionManager()
    var body: some View {
        ZStack {
            Image("playButtonBackground")
                .resizable()
                .scaledToFit()
                .rotation3DEffect(
                    .degrees(motion != nil ? Double(motion!.gravity.y * 50) : 0),
                    axis: (x: 0, y: 1, z: 0))
                .rotation3DEffect(.degrees(motion != nil ? -Double(motion!.gravity.x * 15) : 0), axis: (x: 1, y: 0, z: 0))
        }
        .onAppear {
            if motionManager.isDeviceMotionAvailable {
                self.motionManager.deviceMotionUpdateInterval = 1.0/60
                self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
                    if let validData = data {
                        self.motion = validData
                    }
                }
            }
        }
    }
}

struct ButtonPlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}


