//
//  Canada.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

struct Canada: View {
    var body: some View {
        VStack {
            Text("Canada").font(.title)
            Text("Biggest Map some think its the most fun, lots of empty spaces, has two optional scenarios").font(.body)
        }.tabItem {
            Text("Canada")
        }
    }
}

struct Canada_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Canada()
        }
    }
}
