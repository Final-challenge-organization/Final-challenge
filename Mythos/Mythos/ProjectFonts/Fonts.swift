//
//  Fonts.swift
//  Mythos
//
//  Created by Luiz Sena on 09/10/23.
//

import Foundation
import SwiftUI


enum MyCustomFonts {
    case CabinBold
    case CabinMediumItalic
    case CeasarDressingRegular

    var font: Font {
        switch self {
        case .CabinMediumItalic:
            return Font.custom("Cabin-MediumItalic", size: 15)
        case .CabinBold:
            return Font.custom("Cabin-Bold", size: 18)
        case .CeasarDressingRegular:
            return Font.custom("CaesarDressing", size: 30)
        }
    }
}
