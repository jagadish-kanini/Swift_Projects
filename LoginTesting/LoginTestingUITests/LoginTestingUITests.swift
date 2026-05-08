//
//  LoginTestingUITests.swift
//  LoginTestingUITests
//
//  Created by Jagadish Mangini on 08/05/26.
//

import XCTest

final class LoginTestingUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testEmptyFieldsShowsError() throws {
        app.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Error"].exists)
    }

    @MainActor
    func testInvalidEmailShowsError() throws {
        let emailField = app.textFields["Enter Email"]
        emailField.tap()
        emailField.typeText("invalidemail")
        
        let passwordField = app.secureTextFields["Enter Password"]
        passwordField.tap()
        sleep(1)
        passwordField.typeText("securePass")
        
        app.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Invalid Email"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testShortPasswordShowsError() throws {
        let emailField = app.textFields["Enter Email"]
        emailField.tap()
        emailField.typeText("user@example.com")
        
        let passwordField = app.secureTextFields["Enter Password"]
        passwordField.tap()
        sleep(1)
        passwordField.typeText("123")
        
        app.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Invalid Password"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testValidLoginShowsSuccess() throws {
        let emailField = app.textFields["Enter Email"]
        emailField.tap()
        emailField.typeText("user@example.com")
        
        let passwordField = app.secureTextFields["Enter Password"]
        passwordField.tap()
        sleep(1)
        passwordField.typeText("securePass")
        
        app.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Success"].waitForExistence(timeout: 2))
    }
}
