//
//  Navigation.swift
//  Which 22
//
//  Created by shaun on 9/27/21.
//

import Foundation

let navigationKey = "NAVIGATION"
class Navigation: ObservableObject {
    private var isTesting = false

    init(testing: Bool = false) {
        // NOTE: if this were not an example app we would use some sort of DI to make this unit testable
        guard !testing else {
            isTesting = true
            return
        }
        if let aUrlStr = UserDefaults.standard.string(forKey: navigationKey) {
            self.url = URL(string: aUrlStr)
        }
    }

    @Published var mainNav: MainNavigation = .uk {
        didSet {
            setURL()
        }
    }

    @Published var ukNavigation: UKNavigation = .init() {
        didSet {
            setURL()
        }
    }

    var url: URL? {
        get {
            guard let url = URL(string: "whichtwentytwo://trains.com/") else { return .none }

            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return .none}

            switch mainNav {
            case .uk:
                ukNavigation.configure(&urlComponents)
            case .canada, .mexico:
                urlComponents.path = "/\(mainNav)"
            }

            return urlComponents.url

        }
        set {
            guard let url = newValue else {
                return print("[error] no pre set URL")
            }
            parseURL(url: url)
        }
    }



    private func setURL() {
        if let url = url, !isTesting {
            UserDefaults.standard.setValue(url.absoluteString, forKey: navigationKey)
        }
    }

    private func parseURL(url: URL) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        let path = urlComponents.path

        guard let first = path.split(separator: "/").first else { return }

        mainNav = MainNavigation(rawValue: "\(first)") ?? .uk

        switch mainNav {
        case .uk:
            self.ukNavigation.parse(urlComponents)
        default:
            break
        }
    }
}

struct UKNavigation: Equatable {
    enum Scenario: String, Equatable {
        case standard = ""
        case nrs
        case mrs
    }

    struct Options: Equatable {
        var stackExploration: Bool = true
        var singleShareTaxHaven: Bool = true
        var twentyTwoPlus: Bool = false

       fileprivate var queryItems: [URLQueryItem] {
            var queryItems = [URLQueryItem]()
            let defaultOptions = Options()

            if stackExploration != defaultOptions.stackExploration {
                queryItems.append(.init(name: "stackExploration", value: "\(stackExploration)"))
            }

            if singleShareTaxHaven != defaultOptions.singleShareTaxHaven {
                queryItems.append(.init(name: "singleShareTaxHaven", value: "\(singleShareTaxHaven)"))
            }

            if twentyTwoPlus != defaultOptions.twentyTwoPlus {
                queryItems.append(.init(name: "twentyTwoPlus", value: "\(twentyTwoPlus)"))
            }

            return queryItems
        }

        static func make(from queryItems: [URLQueryItem]) -> Options {
            var options = Options()

            if let seqi = queryItems.first(where: { $0.name == "stackExploration" }) {
                options.stackExploration = Bool(seqi.value ?? "") ?? options.stackExploration
            }

            if let seqi = queryItems.first(where: { $0.name == "singleShareTaxHaven" }) {
                options.singleShareTaxHaven = Bool(seqi.value ?? "") ?? options.singleShareTaxHaven
            }

            if let seqi = queryItems.first(where: { $0.name == "twentyTwoPlus" }) {
                options.twentyTwoPlus = Bool(seqi.value ?? "") ?? options.twentyTwoPlus
            }

            return options
        }
    }

    var scenario: Scenario = .standard
    var options: Options = .init()


    func configure(_  components: inout URLComponents) {
        components.path = "/uk"

        switch scenario {
        case .standard:
            break
        case .nrs, .mrs:
            components.path = "/uk/\(scenario)"
        }

        let defaultOptions = Options()
        guard options != defaultOptions else { return }

        components.queryItems = options.queryItems
    }

    mutating func parse(_ urlComponents: URLComponents) {
        if let lastComponent = urlComponents.path.lowercased().split(separator: "/").last, "\(lastComponent)" != "uk" {
            scenario = Scenario(rawValue: "\(lastComponent)") ?? .standard
        }

        if let queryItems = urlComponents.queryItems {
            options = Options.make(from: queryItems)
        }
    }
}
