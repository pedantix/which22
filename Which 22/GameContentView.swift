//
//  GameContentView.swift
//  Which 22
//
//  Created by shaun on 9/27/21.
//

import SwiftUI

struct GameContentView<OptionsView: View>: View {
    let gameData: Game

    let optionsView: (() -> OptionsView)

    var body: some View {
        VStack {
            Text(gameData.title).font(.title).padding()
            ScrollView {
                VStack {
                    gameData.icon
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    optionsView()
                    Spacer()
                    ForEach(gameData.gameDescription, id: \.1) {
                        Text($0.1).padding().font($0.0)
                        Spacer()
                    }
                }
            }
        }
        .tabItem {
            Text(gameData.title)
        }
    }

    init(gameData:Game, @ViewBuilder optionsView: @escaping (() -> OptionsView)) {
        self.gameData = gameData
        self.optionsView = optionsView
    }
}

extension GameContentView where OptionsView == EmptyView {
    init(gameData:Game) {
        self.gameData = gameData
        self.optionsView = { EmptyView() }
    }
}

struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameContentView(gameData: CanadaGame()) {
                EmptyView()
            }

            GameContentView(gameData: CanadaGame(), optionsView:{ Text("snell") })
        }
    }
}
