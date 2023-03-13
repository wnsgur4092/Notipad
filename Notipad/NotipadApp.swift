//
//  NotipadApp.swift
//  Notipad
//
//  Created by JunHyuk Lim on 11/3/2023.
//

import SwiftUI

@main
struct NotipadApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding == true{
                OnBoardingView()
            } else {
                ContentView()
                    .environmentObject(TaskViewModel())
            }
        }
    }
}
