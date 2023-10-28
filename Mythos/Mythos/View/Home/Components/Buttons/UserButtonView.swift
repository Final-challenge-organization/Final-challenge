//
//  UserButtonView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct UserButtonView: View {
    @State var nameText: String = ""
    @State var isSaved: Bool = true

    private let dataStorage = DataStorage()

    var body: some View {
        HStack {
            if isSaved {

                TextField("Digite seu nome", text: $nameText)
                    .textFieldStyle(.plain)
                    .disabled(isSaved)
            } else {
                TextField("Digite seu nome", text: $nameText)
                    .textFieldStyle(.roundedBorder)
                    .disabled(isSaved)
            }

            Button(action: {
                isSaved.toggle()
                if !nameText.isEmpty {
                    dataStorage.changeUserName(username: nameText)
                    dataStorage.saveUserName()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(maxWidth: 30, maxHeight: 30)
                        .scaledToFit()
                        .foregroundColor(.white)
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.black)

                }
            })
        }
        .onAppear {
            dataStorage.loadUserName()
            nameText = dataStorage.getUserName()
        }
    }
}

struct UserButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UserButtonView()
    }
}
