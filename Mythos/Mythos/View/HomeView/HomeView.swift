//
//  HomeView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct HomeView: View {
    //Desligar animações de navegação
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    @State private var isShowingAlert = false
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Image("backgroundHome")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    VStack(alignment: .leading){
                        HStack(alignment: .top) {
                            UserButtonView()
                                .frame(width: geo.size.width/4,
                                       height: geo.size.height/6)
                            Spacer()
                            Button(action: {isShowingAlert.toggle()}, label: {ConfigButtonView()})

                        }.padding(27)

                        HStack(){
                            Spacer()
                            NavigationLink(destination: WaitingRoomView(),
                                           label: {
                                PlayButtonView()
                                    .shadow(radius: 10)
                                    .frame(width: geo.size.width/5,
                                           height: geo.size.height/1.9)
                            })
                            Spacer()
                        }
                        //MARK: - BOTÃO STORE
                        HStack(alignment: .top){
                            Spacer()
                        }
                        .padding(.top, 80)
                    }
                    .alert(isPresented: $isShowingAlert, content: {Alert(title: Text("VERSÃO BETA"))})

                }
            }

        }
    }


}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().previewInterfaceOrientation(.landscapeLeft)
    }
}
