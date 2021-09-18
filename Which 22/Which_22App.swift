//
//  Which_22App.swift
//  Which 22
//
//  Created by shaun on 9/17/21.
//

import SwiftUI

let navigationKey = "NAVIGATION"
class Navigation: ObservableObject {
    @Published var mainNav: MainNavigation = .uk {
        didSet {
            setURL()
        }
    }

    @Published var urlComponents: URLComponents?

    var url: URL? {
        get {
            return URL(string: "whichtwentytwo://trains.com/\(mainNav)")
        }
        set {
            guard let url = newValue else {
                return print("[error] no pre set URL")
            }
            parseURL(url: url)
        }
    }

    init() {
        if let aUrlStr = UserDefaults.standard.string(forKey: navigationKey) {
            self.url = URL(string: aUrlStr)
        }
    }

    private func setURL() {
        if let url = url {
            UserDefaults.standard.setValue(url.absoluteString, forKey: navigationKey)
        }
    }

    private func parseURL(url: URL) {
        urlComponents = URLComponents(string: url.absoluteString)

        let pathComponents = url.pathComponents.filter { $0 != "/"}
        guard let first = pathComponents.first else { return }
        mainNav = MainNavigation(rawValue: "\(first)") ?? .uk

        // TODO: optional params
    }
}


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
