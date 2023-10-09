//
//  ConfigurationView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct ConfigurationView: View {
    var body: some View {
        List{
            Section(header: Text("Informações")) {
                Text("Versão: BETA")
            }
        }
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
