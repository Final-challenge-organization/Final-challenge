//
//  CardViewModel.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cardSelected: Card? = nil
    @Published var isTapped: Bool = false
    @Published var killTapped: Bool = false
}
