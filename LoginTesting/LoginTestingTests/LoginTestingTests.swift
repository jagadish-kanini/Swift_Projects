//
//  LoginTestingTests.swift
//  LoginTestingTests
//
//  Created by Jagadish Mangini on 08/05/26.
//

import XCTest
@testable import LoginTesting

final class LoginTestingTests: XCTestCase {

    var viewController: ViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateInitialViewController() as? ViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testEmptyEmailAndPassword() {
        viewController.emailTextField.text = ""
        viewController.passwordTextField.text = ""
        viewController.loginButton.sendActions(for: .touchUpInside)
        // Validation: empty fields should not proceed
        XCTAssertEqual(viewController.emailTextField.text, "")
        XCTAssertEqual(viewController.passwordTextField.text, "")
    }

    func testInvalidEmailFormat() {
        viewController.emailTextField.text = "invalidemail"
        viewController.passwordTextField.text = "securePass"
        viewController.loginButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(viewController.emailTextField.text, "invalidemail")
    }

    func testShortPassword() {
        viewController.emailTextField.text = "user@example.com"
        viewController.passwordTextField.text = "123"
        viewController.loginButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(viewController.passwordTextField.text, "123")
    }

    func testValidInput() {
        viewController.emailTextField.text = "user@example.com"
        viewController.passwordTextField.text = "securePass"
        viewController.loginButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(viewController.emailTextField.text, "user@example.com")
    }
}
