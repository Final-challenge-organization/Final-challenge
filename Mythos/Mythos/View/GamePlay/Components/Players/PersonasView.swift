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
    let isYourTurn: Bool
    let image: Data

    private let dataStorage = DataStorage()

    var body: some View {
        //MARK: - LEFT LOCATION
        if index == 1 {
            VStack(spacing: 10) {
                VStack (spacing: 5){
                    Image(uiImage: UIImage(data: image) ?? UIImage())
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 52, height: 52)
                        .scaledToFit()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 4)
                                .frame(width: 52, height: 52)
                                .foregroundColor(isYourTurn ? Color("selectedPlayerColor") : .clear)

                        }
                        .overlay {
                            Circle()
                                .strokeBorder(isYourTurn ? Color("selectedPlayerColor") : .clear, lineWidth: 4)
                                .background(Circle().fill(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1))))                            .frame(width: 30, height: 30)
                                .overlay {
                                    Text("\(lifePerson)")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                                .offset(x: -25, y: -25)
                        }
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 25, height: 10)
                        .rotationEffect(Angle(degrees:180))
                }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .border(isYourTurn ? Color("selectedPlayerColor") : .clear, width: 2)
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
            VStack(spacing: 10) {
                VStack (spacing: 5) {
                    Image(uiImage: UIImage(data: image) ?? UIImage())
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 52, height: 52)
                        .scaledToFit()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 4)
                                .frame(width: 52, height: 52)
                                .foregroundColor(isYourTurn ? Color("selectedPlayerColor") : .clear)

                        }
                        .overlay {
                            Circle()
                                .strokeBorder(isYourTurn ? Color("selectedPlayerColor") : .clear, lineWidth: 4)
                                .background(Circle().fill(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1))))                            .frame(width: 30, height: 30)
                                .overlay {
                                    Text("\(lifePerson)")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                                .offset(x: 25, y: -25)
                        }
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 25, height: 10)
                        .rotationEffect(Angle(degrees:180))
                }
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .border(isYourTurn ? Color("selectedPlayerColor") : .clear, width: 2)
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
                HStack (spacing: -10) {
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 45, height: 12)
                        .rotationEffect(Angle(degrees: 270))
//                        .offset(y:0)
                    VStack {
                        Image(uiImage: dataStorage.getUserImage())
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 72, height: 72)
                            .scaledToFit()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 4)
                                    .frame(width: 72, height: 72)
                                    .foregroundColor(isYourTurn ? Color("selectedPlayerColor") : .clear)

                            }
                            .overlay {
                                Circle()
                                    .strokeBorder(isYourTurn ? Color("selectedPlayerColor") : .clear, lineWidth: 4)
                                    .background(Circle().fill(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1))))                            .frame(width: 30, height: 30)
                                    .overlay {
                                        Text("\(lifePerson)")
                                            .foregroundColor(.yellow)
                                            .bold()
                                    }
                                    .offset(x: 35, y:-35)
                            }
                    }
                }
                .offset(x: 180)
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
            ZStack {
                VStack (spacing: 5) {
                    Triangle()
                        .fill(Color(red: 9/255, green: 24/255, blue: 63/255))
                        .frame(width: 25, height: 10)
                        .rotationEffect(Angle(degrees: 0))
                    Image(uiImage: UIImage(data: image) ?? UIImage())
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 52, height: 52)
                        .scaledToFit()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 4)
                                .frame(width: 52, height: 52)
                                .foregroundColor(isYourTurn ? Color("selectedPlayerColor") : .clear)

                        }
                        .overlay {
                            Circle()
                                .strokeBorder(isYourTurn ? Color("selectedPlayerColor") : .clear, lineWidth: 4)
                                .background(Circle().fill(Color(UIColor.init(red: 9/255, green: 24/255, blue: 63/255, alpha: 1))))                            .frame(width: 30, height: 30)
                                .overlay {
                                    Text("\(lifePerson)")
                                        .foregroundColor(.yellow)
                                        .bold()
                                }
                                .offset(x: -25, y:25)
                        }
                }
                .offset(x: -100, y: 10)
                HStack(spacing: -35) {
                    Spacer()
                    ForEach(cards, id: \.id) {
                        card in
                        BackCardView()
                            .border(isYourTurn ? Color("selectedPlayerColor") : .clear, width: 2)
                            .frame(width: 55, height: 115)
                    }
                    .transition(.move(edge: .bottom))
                    Spacer()
                }
                .animation(.easeInOut, value: cards.count)
                .offset(y: 10)
                .frame(maxWidth: 110.51, maxHeight: 177.4)
            }
        }
        if index == 5 {
            VStack(spacing: 0) {
                VStack {
                    Text(namePerson.description)
                        .padding(3.8)
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

struct PersonasView_Previews: PreviewProvider {
    static var previews: some View {
        let namePerson: String = "Charlingtonglaevionbeecheknavare dos Anjos Mendonça "
        let lifePerson = 30
        let image = "sara"
        Group {
            let index = 0
            @State var cards: [Card] = [
                Card(id: 1234,
                     name: "Teste1",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 5,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 34343,
                     name: "Teste2",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 2,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 243342,
                     name: "Teste3",
                     imageName: "escudoDeJustica", type: .reaction,
                     damage: 1,
                     effect: "TESTANDO",
                     description: "testando")
            ]
            PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index, isYourTurn: (1 != 0), image: UIImage(named: image)!.pngData()!)
        }
        .previewDisplayName("USER LOCATION")
        Group {
            let index = 1
            @State var cards: [Card] = [
                Card(id: 1234,
                     name: "Teste1",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 5,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 34343,
                     name: "Teste2",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 2,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 243342,
                     name: "Teste3",
                     imageName: "escudoDeJustica", type: .reaction,
                     damage: 1,
                     effect: "TESTANDO",
                     description: "testando")
            ]
            PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index, isYourTurn: (1 != 0), image: UIImage(named: image)!.pngData()!)
        }.previewDisplayName("LEFT LOCATION")
        Group {
            let index = 2
            @State var cards: [Card] = [
                Card(id: 1234,
                     name: "Teste1",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 5,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 34343,
                     name: "Teste2",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 2,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 243342,
                     name: "Teste3",
                     imageName: "escudoDeJustica", type: .reaction,
                     damage: 1,
                     effect: "TESTANDO",
                     description: "testando")
            ]
            PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index, isYourTurn: (1 != 0), image: UIImage(named: image)!.pngData()!)
        }.previewDisplayName("TOP LOCATION")
        Group {
            let index = 3
            @State var cards: [Card] = [
                Card(id: 1234,
                     name: "Teste1",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 5,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 34343,
                     name: "Teste2",
                     imageName: "olharDeCiclope", type: .action(.damage),
                     damage: 2,
                     effect: "TESTANDO",
                     description: "testando"),
                Card(id: 243342,
                     name: "Teste3",
                     imageName: "escudoDeJustica", type: .reaction,
                     damage: 1,
                     effect: "TESTANDO",
                     description: "testando")
            ]
            PersonasView(cards: cards, namePerson: namePerson, lifePerson: lifePerson, index: index, isYourTurn: (1 != 0), image: UIImage(named: image)!.pngData()!)
        }.previewDisplayName("RIGHT LOCATION")
    }
}

protocol MaybeGameViewPersonaViewDelegate {
    func updatePersonaViewLife(with life: String)
}
