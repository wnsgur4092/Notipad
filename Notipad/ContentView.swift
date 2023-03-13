//
//  ContentView.swift
//  Notipad
//
//  Created by JunHyuk Lim on 11/3/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .environmentObject(TaskViewModel())
//        HistoryView()
//            .environmentObject(TaskViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
