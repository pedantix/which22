//
//  Mexico.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

struct Mexico: View {
    var body: some View {
        VStack {
            Text("Mexico").font(.title)
            Text("Smallest Map, no varients or scenarios but a national train company that keeps it interesting with a twisted Mechanic").font(.body)
        }.tabItem {
            Text("Mexcio")
        }
    }
}

struct Mexico_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Mexico()
        }
    }
}
