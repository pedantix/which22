//
//  Which_22Tests.swift
//  Which 22Tests
//
//  Created by shaun on 9/17/21.
//

import XCTest
@testable import Which_22

class Which_22Tests: XCTestCase {
    var navigation = Navigation(testing: true)

    func testDefault() {
        XCTAssertEqual(navigation.mainNav, .uk)
    }

    func testMainNav() {
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk")
        navigation.mainNav = .canada
        XCTAssertEqual(self.navigation.url?.absoluteString, "whichtwentytwo://trains.com/canada")
        navigation.mainNav = .mexico
        XCTAssertEqual(self.navigation.url?.absoluteString, "whichtwentytwo://trains.com/mexico")
    }


    func testUKNavigationScenarios() {
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk")
        navigation.ukNavigation = .init(scenario: .nrs, options: .init())
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk/nrs")
        navigation.ukNavigation = .init(scenario: .mrs, options: .init())
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk/mrs")
    }


    func testUKNavigationOptions() {
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk")
        navigation.ukNavigation = .init(options: .init(stackExploration: false))
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk?stackExploration=false")
        navigation.ukNavigation = .init(options: .init(singleShareTaxHaven: false))
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk?singleShareTaxHaven=false")
        navigation.ukNavigation = .init(options: .init(twentyTwoPlus: true))
        XCTAssertEqual(navigation.url?.absoluteString, "whichtwentytwo://trains.com/uk?twentyTwoPlus=true")
    }

    func testParseMexico() {
        navigation.url = URL(string: "whichtwentytwo://trains.com/mexico")
        XCTAssertEqual(navigation.mainNav, .mexico)
    }

    func testParseCanada() {
        navigation.url = URL(string: "whichtwentytwo://trains.com/canada")
        XCTAssertEqual(navigation.mainNav, .canada)
    }

    func testParseUKAndScenarios() {
        navigation.url = URL(string: "whichtwentytwo://trains.com/uk")
        XCTAssertNotNil(navigation.ukNavigation)
        XCTAssertEqual(navigation.mainNav, .uk)

        navigation.url = URL(string: "whichtwentytwo://trains.com/nrs")
        XCTAssertNotNil(navigation.ukNavigation)
        XCTAssertEqual(navigation.mainNav, .uk)
        XCTAssertEqual(navigation.ukNavigation.scenario, .nrs)

        navigation.url = URL(string: "whichtwentytwo://trains.com/mrs")
        XCTAssertNotNil(navigation.ukNavigation)
        XCTAssertEqual(navigation.mainNav, .uk)
        XCTAssertEqual(navigation.ukNavigation.scenario, .mrs)
    }


    func testParseUKNavigationOptions() {
        navigation.url = URL(string: "whichtwentytwo://trains.com/uk")
        XCTAssertEqual(navigation.ukNavigation, .init())


        navigation.url = URL(string: "whichtwentytwo://trains.com/uk?stackExploration=false")
        XCTAssertEqual(navigation.ukNavigation, UKNavigation(options: .init(stackExploration: false)))

        navigation.url = URL(string: "whichtwentytwo://trains.com/uk?singleShareTaxHaven=false")
        XCTAssertEqual(navigation.ukNavigation, UKNavigation(options: .init(singleShareTaxHaven: false)))

        navigation.url = URL(string: "whichtwentytwo://trains.com/uk?twentyTwoPlus=true")
        XCTAssertEqual(navigation.ukNavigation, UKNavigation(options: .init(twentyTwoPlus: true)))
    }
}

