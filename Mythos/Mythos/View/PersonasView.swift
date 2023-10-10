//
//  PersonasView.swift
//  Mythos
//
//  Created by Narely Lima on 10/10/23.
//

import SwiftUI

struct PersonasView: View {
    
    @State var namePerson: String
    @State var lifePerson: String
    
    var body: some View {
        VStack {
            Text(namePerson)
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30)
                .overlay {
                    Text("\(lifePerson)")
                    
                }
        }
    }
}

//    struct PersonasView_Previews: PreviewProvider {
//        static var previews: some View {
//            PersonasView()
//        }
//    }
