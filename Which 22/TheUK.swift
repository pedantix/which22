//
//  TheUK.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

struct TheUK: View {
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        GameContentView(gameData: UKGame(ukNavigation: navigation.ukNavigation)) {
            ukNavView
        }
    }

    @ViewBuilder
    private var ukNavView: some View {
        VStack {

            Toggle(isOn: $navigation.ukNavigation.options.singleShareTaxHaven) {
                Text("Single Share Tax Haven")
            }
            Toggle(isOn: $navigation.ukNavigation.options.twentyTwoPlus) {
                Text("Twenty Two Plus")
            }
            Toggle(isOn: $navigation.ukNavigation.options.stackExploration) {
                Text("Stack Exploration")
            }

            Picker("Scenario", selection: $navigation.ukNavigation.scenario) { 
                Text("Standard").tag(UKNavigation.Scenario.standard)
                Text("NRS").tag(UKNavigation.Scenario.nrs)
                Text("MRS").tag(UKNavigation.Scenario.mrs)
            }.pickerStyle(SegmentedPickerStyle())
        }.padding()
    }
}

struct TheUK_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            TheUK()
        }.environmentObject(Navigation())
    }
}
