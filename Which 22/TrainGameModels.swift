//
//  TrainGameModels.swift
//  Which 22
//
//  Created by shaun on 9/27/21.
//

import SwiftUI

typealias GameDescription = [(Font, String)]

protocol Game {
    var icon: Image { get }
    var title: String { get }
    var gameDescription: GameDescription { get }
}

struct CanadaGame: Game {
    var icon: Image {
        return Image(decorative: "22CABox", bundle: .none)
    }

    let title = "Canada"

    var gameDescription: GameDescription = [(
        .body,
"""
1822CA is an 18xx game that covers Canada from coast to coast and reimplements the 1822 system. The board is 33 percent larger than 1822, has 30 private companies, and 30 minor companies. The game has 10 public companies including the Canadian Pacific Railway that starts on both the east and west sides of the board.

The game consists of an alternating series of stock rounds and operating rounds. Initially, there is one operating round between each stock round, and then once the first 2-train is bought, two operating rounds between each stock round. The final set of operating rounds has three rounds.

In stock rounds, players act as investors, buying and selling shares in the various companies. The player with the most shares in each company is the company’s director and decides all actions that the company takes in the operating round.

In operating rounds, players, as company directors, run the various companies that they control. They choose whether to build track, place station tokens, which trains to run on which routes, whether to pay or withhold dividends and whether to invest in more trains, etc.

The game ends as soon as one of the following conditions is met:
Immediately, if the first stock round ends with nothing sold.

At the end of the operating round in which a company’s stock market value reaches the game end value of the stock market.

At the end of the first operating round following a stock round in which a major company’s stock market value reaches the game end value of the stock market.

At the end of the first operating round following a stock round in which the bank runs out of money. The game still ends at that point even if the bank later becomes solvent. The bank continues to pay demands due of it even when broken; players should record these, or each lend the bank some money.

When the bank runs out of money in an OR, complete the pair of ORs and then run one additional OR (for a total of 3 ORs in the final set). The game still ends at that point even if the bank later becomes solvent. The bank continues to pay demands due of it even when broken; players should record these, or each lend the bank some money.

Each player’s total wealth is the value of their stock, at current prices, plus cash on hand. Concession certificates, if they are still open and held by players, count face value. Private company certificates and company assets count for nothing. The richest player wins.
"""
    )]
}

struct MexcioGame: Game {
    var icon: Image {
        return Image(decorative: "22mxbox", bundle: .none)
    }

    let title = "Mexcio"

    var gameDescription: GameDescription = [(
        .body,
"""
Set in Mexico, this is an 18xx game about wealthy investors buying and selling shares in the nation's burgeoning railway industry.

Based on Francis Tresham's 1829, and more specifically inspired by Simon Cutforth's 1822: The Railways of Great Britain, this 18xx title features multiple auction rounds throughout the game, distributing the minor companies, private companies, and concessions in a randomized order, ensuring each game will play out quite differently.
"""
    )]
}

struct UKGame: Game {
    var ukNavigation: UKNavigation

    var icon: Image {
        return Image(decorative: "22uk", bundle: .none)
    }

    let title = "Great Britain"

    var gameDescription: GameDescription {
        var gd: GameDescription = [
            (.title2, "Main Game Description"),
            (.body, "standard text from bgg.com, but its down"),
            (.title2, "Tax Haven Rules"),
            (.body, taxHavenInfo),
            (.title2, "Stack Exploration"),
            (.body, stackExploration),
            (.title2, "Scenario: \(ukNavigation.scenario.rawValue.uppercased())"),
            (.body, scenarioText)
        ]

        if ukNavigation.options.twentyTwoPlus {
            gd.append(contentsOf: [(.title2, "1822+"), (.body, "The 1822+ expansion introduces three additional private companies and changes the private company set up rules.  Only 18 of the 21 available private companies are in play. Players may wish to use the full set, or experiment with alternative ways of selecting the private companies to be discarded and the way in which they enter play. The expansion also introduces an additional six minor companies.  There are thus 30 minor companies in play in total.")])
        }

        return gd
    }


    private var taxHavenInfo: String {
        if ukNavigation.options.singleShareTaxHaven {
            return "In this varient of the game, the tax haven can be used as a free slot for one additional share. Revenue counts as end game score not towards ownership capital."
        } else {
            return "In this varient of the game, the tax haven can be used as a free slot where one share can additionally be bought from the owners money then earned revenue can be used to buy more shares"
        }
    }

    private var stackExploration: String {
        if ukNavigation.options.stackExploration {
            return "In this varient of the game, players are able to look ahead and see what minors, privates and concessions are coming out in the near future."
        } else {
            return "In this varient of the game, players are not able to look ahead and see what minors, privates and concessions are coming out in the near future. They can only see what is on the board and on the top of the card stacks. This varient can fasciltate faster play."
        }
    }

    private var scenarioText: String {
        switch ukNavigation.scenario {
        case .standard:
            return "The full board is available, conquer from Edinborough to Brighton, Great Britain lucrative rail way industry could be yours."
        case .mrs:
            return "The center of the board is yours to conquer, from London to Scottland to Wales build your empire."
        case .nrs:
            return "From Aberdeen to Birmingham, run the greatest train empire ever."
        }
    }
}

