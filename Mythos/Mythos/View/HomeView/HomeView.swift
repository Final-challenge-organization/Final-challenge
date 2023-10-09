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

    @State private var isShowingSheet = false
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                VStack(alignment: .leading){
                    HStack(alignment: .top) {
                        NavigationLink(destination: ProfileView(),
                                       label: {
                            UserButtonView()
                                .frame(width: geo.size.width/4,
                                       height: geo.size.height/6)
                        })
                        Spacer()
                        CoinsView()
                            .frame(width: geo.size.width/6 ,
                                   height: geo.size.height/8.4)
                        CoinsView()
                            .frame(width: geo.size.width/6 ,
                                   height: geo.size.height/8.4)

                        Button(action: {isShowingSheet.toggle()}, label: {ConfigButtonView()})



                    }.padding(27)

                    HStack(){
                        Spacer()
                        NavigationLink(destination: WaitingRoomView(),
                                       label: {
                            PlayButtonView()
                                .frame(width: geo.size.width/5,
                                       height: geo.size.height/1.9)
                        })
                        Spacer()
                        NavigationLink(destination: InventoryView(),
                                       label: {
                            InventoryButtonView()
                                .frame(width: geo.size.width/5,
                                       height: geo.size.height/1.9)
                        })
                        Spacer()
                    }
                    HStack(alignment: .top){
                        NavigationLink(destination: {StoreView()},
                                       label: {
                            StoreButtonView()
                                .frame(width: geo.size.height/8)
                                .padding(.leading, 32)
                        })
                        Spacer()
                    }
                }
                .alert(isPresented: $isShowingSheet, content: {Alert(title: Text("VERSÃO BETA"))})

                .ignoresSafeArea()
            }
        }
    }


}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().previewInterfaceOrientation(.landscapeLeft)
    }
}
