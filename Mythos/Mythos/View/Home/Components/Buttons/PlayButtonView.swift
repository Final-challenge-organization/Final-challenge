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
    let textButton: String

    var body: some View {
        ZStack {
            Image("backgroundButtonPlayer")
                .resizable()
                .scaledToFit()
                .offset(
                    x: motion != nil ? CGFloat(motion!.gravity.x * 50): 0,
                    y: 0)
                .rotation3DEffect(
                    .degrees(motion != nil ? Double(motion!.gravity.x * 50) : 0),
                    axis: (x: 0, y: 1, z: 0))
                .overlay {
                    Text(textButton)
                        .padding([.trailing, .leading])
                        .font(MyCustomFonts.CeasarDressingRegular.font)
                        .minimumScaleFactor(0.01)
                        .lineLimit(2)
                        .foregroundColor(Color(red: 251/255, green: 183/255, blue: 49/255))
                        .offset(x: -5)


                }
        }
//        .onAppear {
//            if motionManager.isDeviceMotionAvailable {
//                self.motionManager.deviceMotionUpdateInterval = 1.0/60
//                self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
//                    if let validData = data {
//                        self.motion = validData
//                    }
//                }
//            }
//        }
    }
}

//struct ButtonPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayButtonView()
//    }
//}


