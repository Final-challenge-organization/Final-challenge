//
//  PersonasView.swift
//  Mythos
//
//  Created by Narely Lima on 10/10/23.
//

import SwiftUI

struct PersonasView: View {
    
    let namePerson: String
    let lifePerson: Int

    var body: some View {
        VStack {
            Text(namePerson.description)
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30)
                .overlay {
                    Text("\(lifePerson)")
                    
                }
        }
    }
}

protocol MaybeGameViewPersonaViewDelegate {
    func updatePersonaViewLife(with life: String)
}
