//
//  Canada.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

struct Canada: View {
    let gameData = CanadaGame()

    var body: some View {
        GameContentView(gameData: gameData)
    }
}

struct Canada_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Canada()
        }
    }
}
