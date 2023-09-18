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

    var body: some View {
        GeometryReader { geo in
            NavigationView {
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

                        ConfigButtonView()
                            .frame(width: geo.size.height/8)

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
