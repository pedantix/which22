//
//  Which_22App.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

@main
struct Which_22App: App {
    @StateObject var navigation = Navigation()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigation)
        }
    }
}
