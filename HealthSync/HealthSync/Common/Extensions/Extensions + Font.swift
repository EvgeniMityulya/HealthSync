//
//  Extensions + Font.swift
//  HealthSync
//
//  Created by Евгений Митюля on 10/18/24.
//

import SwiftUI

enum LatoFont: String {
    case black = "Lato-Black"
    case blackItalic = "Lato-BlackItalic"
    case bold = "Lato-Bold"
    case boldItalic = "Lato-BoldItalic"
    case italic = "Lato-Italic"
    case light = "Lato-Light"
    case lightItalic = "Lato-LightItalic"
    case regular = "Lato-Regular"
    case hairline = "Lato-Hairline"
    case hairlineItalic = "Lato-HairlineItalic"
}

extension Font {
    static func lato(style: LatoFont, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
}
