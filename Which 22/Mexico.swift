//
//  Mexico.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

struct Mexico: View {
    var body: some View {
        GameContentView(gameData: MexcioGame())
    }
}

struct Mexico_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Mexico()
        }
    }
}
