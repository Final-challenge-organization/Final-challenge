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
                .offset(
                    x: motion != nil ? CGFloat(motion!.gravity.x * 50): 0,
                    y: 0)
                .rotation3DEffect(
                    .degrees(motion != nil ? Double(motion!.gravity.x * 50) : 0),
                    axis: (x: 0, y: 1, z: 0))
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



//
//import SwiftUI
//import CoreMotion
//
//struct ParallaxView: View {
//    @State var motion: CMDeviceMotion? = nil
//    let motionManager = CMMotionManager()
//    var body: some View {
//        ZStack {
//            Image("emptyCard")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 350, height: 450)
//            Image("shield")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .shadow(color: .red, radius: 8)
//                .frame(width: 250, height: 250)
//                .padding(.bottom, 170)
//
//        }
//
//    }
//}
//
//struct ParallaxView_Previews: PreviewProvider {
//    static var previews: some View {
//        ParallaxView()
//    }
//}
