//
//  PopUpView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 16/10/23.
//

import Foundation
import SwiftUI

struct PopUptView: View {
    @State private var showingAlert = false
    @State private var name = ""

    var body: some View {
        Button("PopUp") {
            showingAlert.toggle()
        }
        .alert("End Game", isPresented: $showingAlert) {
            Button("OK", action: submit)
        }
    }

    func submit() {
//
    }
}

struct PopUptView_Previews: PreviewProvider {
    static var previews: some View {
      PopUptView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

