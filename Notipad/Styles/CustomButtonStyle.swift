//
//  CustomButtonStyle.swift
//  Notipad
//
//  Created by JunHyuk Lim on 13/3/2023.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let isButtonEnabled: Bool
    let activeStyle: any ButtonStyle
    let disableStyle: any ButtonStyle
    
    let activebgColor : Color = Color.blue
    let activetextColor : Color = Color.white
    
    let disabledbgColor : Color = Color.gray
    let disabledtextColor : Color = Color.white

    func makeBody(configuration: Configuration) -> some View {
        if isButtonEnabled {
            HStack {
                configuration.label.foregroundColor(activetextColor)
                    .font(.system(size: 16).bold())
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
            }
            .frame(maxWidth: .infinity)
            .background(activebgColor.cornerRadius(28))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
        } else {
            HStack {
                configuration.label.foregroundColor(disabledtextColor)
                    .font(.system(size: 16).bold())
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
            }
            //.disabled(true) // 버튼을 비활성화합니다.
            .frame(maxWidth: .infinity)
            .background(disabledbgColor.cornerRadius(28))
        }
    }
}
