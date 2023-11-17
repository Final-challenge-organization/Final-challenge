//
//  DescriptionTutorial.swift
//  Mythos
//
//  Created by Narely Lima on 13/11/23.
//

import SwiftUI

struct DescriptionTutorial: View {

    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.thinMaterial)
            Text(description)
                .font(.body)
                .padding()

        }
    }
}

struct DescriptionTutorial_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionTutorial(description: "Teste")
    }
}
