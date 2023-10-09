//
//  PopUp.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 02/10/23.
//

import Foundation
import SwiftUI

struct PopupView: View {
    @Binding var popupGameOver: Bool

    var body: some View {

        if popupGameOver {
            VisualEffectView(effect: UIBlurEffect(style: .extraLight))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.7)
                .overlay {
                    popGameOver
                        .transition(.scale)
                }
        }
    }

    var popGameOver: some View {
        VStack{
            HStack{
                Image("rima")
                    .resizable()
                    .frame(width: 80 , height: 80, alignment: .bottom)
                    .clipShape(Circle())
                    .padding([.top, .leading], 20)
                    .padding(.bottom,15)
                    .padding(.trailing, 15)
                VStack(alignment: .leading) {
                    Text("Lalalalaa!")
                        .padding(.top,3)
                        .foregroundColor(Color.black)
                        .font(.system(.title, design: .rounded))
                    Text("xxxxx")
                        .foregroundColor(Color.black)
                        .font(.system(.title2, design: .rounded))
                        .padding(.trailing, 10)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .accessibilityElement(children: .combine)
                .accessibilityHint("alertHint")
            }
            Button(action: {

//                sparkles = false
                withAnimation {
                    popGameOver = false
                }
            }) {
                Text("dismiss")
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(Color(.white))
                    .foregroundColor(.black)
                    .clipShape(Rectangle())
            }
        }
        .background {
            Rectangle()
                .fill(Color(red: 255/255, green: 250/255, blue: 205/255))
                .foregroundColor(.black)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 280)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)

    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
