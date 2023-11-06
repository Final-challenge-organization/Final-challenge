//
//  PersonasView.swift
//  Mythos
//
//  Created by Narely Lima on 10/10/23.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct PersonasView: View {

    let cards: [Card]
    let namePerson: String
    let lifePerson: Int
    var index: Int

    var body: some View {
        //MARK: - LEFT LOCATION
        if index == 1 {
            VStack(spacing: -10) {
                VStack {
                    HStack {
                        Text(namePerson.description)
                            .padding(3.8)
                            .foregroundColor(.yellow)
                            .bold()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 9/255, green: 24/255, blue: 63/255)))
                            }

                        Circle()
                            .foregroundColor(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1)))
                            .frame(width: 30, height: 30)
                            .overlay {
                                Text("\(lifePerson)")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                        
                    }
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 35, height: 20)
                        .rotationEffect(Angle(degrees: 180))
                }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .top))
                    .rotation3DEffect(.degrees(10), axis: (x:-40,y:6,z:0))
                    Spacer()
                }
                .animation(.easeInOut, value: cards.count)
                .frame(maxWidth: 110.51, maxHeight: 177.4)
                .rotation3DEffect(Angle(degrees: 50), axis: (x:-20, y:40, z:-10))
            }
        } else
        //MARK: - RIGHT LOCATION
        if index == 3 {
            VStack(spacing: -10) {
                VStack {
                    HStack {

                        Text(namePerson.description)
                            .padding(3.8)
                            .foregroundColor(.yellow)
                            .bold()
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 9/255, green: 24/255, blue: 63/255)))
                            }
                        Circle()
                            .foregroundColor(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1)))
                            .frame(width: 30, height: 30)
                            .overlay {
                                Text("\(lifePerson)")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                    }
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 35, height: 20)
                        .rotationEffect(Angle(degrees: 180))
                }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .top))
                    .rotation3DEffect(.degrees(-10), axis: (x:40,y:-6,z:0))
                    Spacer()
                }
                .animation(.easeInOut, value: cards.count)
                .frame(maxWidth: 110.51, maxHeight: 177.4)
                .rotation3DEffect(Angle(degrees: -50), axis: (x:20, y:40, z:-10))
            }
        }
        //MARK: - USER LOCATION
        if index == 0 {
            VStack(spacing: 0) {
                VStack {

                    HStack {
                        Text(namePerson.description)
                            .padding(3.8)
                            .foregroundColor(.yellow)
                            .bold()
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 9/255, green: 24/255, blue: 63/255)))
                            }
                        Circle()
                            .foregroundColor(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1)))
                            .frame(width: 30, height: 30)
                            .overlay {
                                Text("\(lifePerson)")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                    }
//                    .offset(y: -75)
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 35, height: 20)
                        .rotationEffect(Angle(degrees: 180))
//                        .offset(y: -75)
                }
                .offset(y: -40)
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 55, height: 115)
                    }
                    Spacer()
                }
            }
        }
        //MARK: - TOP LOCATION
        if index == 2 {
            VStack(spacing: 0) {
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .bottom))
                    Spacer()
                }
                .animation(.easeInOut, value: cards.count)
                .offset(y: 50)
                .frame(maxWidth: 110.51, maxHeight: 177.4)
                VStack {
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 35, height: 20)
                        .rotationEffect(Angle(degrees: 0))
                        .offset(y: 40)
                    HStack {
                        Text(namePerson.description)
                            .padding(3.8)
                            .foregroundColor(.yellow)
                            .bold()
                            .background{
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 9/255, green: 24/255, blue: 63/255)))
                            }
                        Circle()
                            .foregroundColor(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1)))
                            .frame(width: 30, height: 30)
                            .overlay {
                                Text("\(lifePerson)")
                                    .foregroundColor(.yellow)
                                    .bold()
                            }
                    }
                    .offset(y: 40)
                }
            }
        }
        if index == 5 {
            VStack(spacing: 0) {
                VStack {
                    Text(namePerson.description)
                        .padding(3.8)
                    Circle()
                        .frame(width: 30, height: 30)
                        .overlay {
                            Text("\(lifePerson)")
                                .bold()
                        }
                }
                .offset(x: 0, y: -75)
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 55, height: 115)
                    }
                    Spacer()
                }
            }
            .foregroundColor(.clear)
        }
    }
}

//struct PersonasView_Previews: PreviewProvider {
//    static var previews: some View {
//        let namePerson: String = "Sarinha"
//        let lifePerson = 30
//        let index = 0
//        @State var cards: [Card] = [
//            Card(id: 1234,
//                 name: "Teste1",
//                 type: .action(.damage), imageName: <#String#>,
//                 damage: 5,
//                 effect: "TESTANDO",
//                 description: "testando"),
//            Card(id: 34343,
//                 name: "Teste2",
//                 type: .action(.damage),
//                 damage: 2,
//                 effect: "TESTANDO",
//                 description: "testando"),
//            Card(id: 243342,
//                 name: "Teste3",
//                 type: .reaction,
//                 damage: 1,
//                 effect: "TESTANDO",
//                 description: "testando")
//        ]
//        PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index)
//    }
//}

protocol MaybeGameViewPersonaViewDelegate {
    func updatePersonaViewLife(with life: String)
}
