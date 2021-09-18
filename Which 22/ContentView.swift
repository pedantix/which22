//
//  ContentView.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

enum MainNavigation: String, Equatable {
    case uk
    case canada
    case mexico
}

struct ContentView: View {
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        TabView(selection: $navigation.mainNav) {
            TheUK().tag(MainNavigation.uk)
            Canada().tag(MainNavigation.canada)
            Mexico().tag(MainNavigation.mexico)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
