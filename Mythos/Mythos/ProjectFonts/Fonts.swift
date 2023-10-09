//
//  Fonts.swift
//  Mythos
//
//  Created by Luiz Sena on 09/10/23.
//

import Foundation
import SwiftUI


enum MyCustomFonts {
    case ConvergenceRegular

    var font: Font {
        switch self {
        case .ConvergenceRegular:
            return Font.custom("Convergence-Regular", size: 18)
        }
    }
}
