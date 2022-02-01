//
//  RocketTest.swift
//  SpaceXTests
//
//  Created by Mohammad Ashraful Kabir on 02/02/2022.
//

import XCTest

class RocketTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRocketWithEmptyRocketId() throws {
        let rocketId = ""
        let expected = expectation(description: "Wait for n seconds")
        let apiHelper = APIHelper()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.ROCKET_ENDPOINT)/\(rocketId)"

        debugPrint("API URL: \(String(describing: urlComponents.url))")

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<Rocket, Error>) in
            switch result {
            case .success(let rocket):
                debugPrint("We got a successful result with: \(rocket)")
                XCTAssertNotNil(rocket)
            case .failure(let error):
                debugPrint("We got a failure trying to get the rocket. The error we got was: \(error.localizedDescription)")
                XCTAssertNotNil(error)
            }
            expected.fulfill()
         }
        self.wait(for: [expected], timeout: 15)
    }
    
    func testRocketWithRocketId() throws {
        let rocketId = "5e9d0d95eda69955f709d1eb"
        let expected = expectation(description: "Wait for n seconds")
        let apiHelper = APIHelper()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.ROCKET_ENDPOINT)/\(rocketId)"

        debugPrint("API URL: \(String(describing: urlComponents.url))")

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<Rocket, Error>) in
            switch result {
            case .success(let rocket):
                debugPrint("We got a successful result with: \(rocket)")
                XCTAssertNotNil(rocket)
            case .failure(let error):
                debugPrint("We got a failure trying to get the rocket. The error we got was: \(error.localizedDescription)")
                XCTAssertNotNil(error)
            }
            expected.fulfill()
         }
        self.wait(for: [expected], timeout: 15)
    }
    
    func testRocketWithWrongRocketId() throws {
        let rocketId = "5e9d0d95eda69955f709d1e"
        
        let expected = expectation(description: "Wait for n seconds")
        let apiHelper = APIHelper()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.ROCKET_ENDPOINT)/\(rocketId)"

        debugPrint("API URL: \(String(describing: urlComponents.url))")

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<Rocket, Error>) in
            switch result {
            case .success(let rocket):
                debugPrint("We got a successful result with: \(rocket)")
                XCTAssertNotNil(rocket)
            case .failure(let error):
                debugPrint("We got a failure trying to get the rocket. The error we got was: \(error.localizedDescription)")
                XCTAssertNotNil(error)
            }
            expected.fulfill()
        }
        self.wait(for: [expected], timeout: 15)
    }

}
