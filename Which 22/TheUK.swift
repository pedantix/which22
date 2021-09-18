//
//  TheUK.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

struct TheUK: View {
    var body: some View {
        VStack {
            Text("The UK").font(.title)
            Text("Origianal 22, having both varients and scenarios").font(.body)
        }.tabItem {
            Text("The UK")
        }
    }
}

struct TheUK_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            TheUK()
        }
    }
}
