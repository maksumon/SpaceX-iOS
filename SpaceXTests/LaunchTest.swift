//
//  LaunchTest.swift
//  SpaceXTests
//
//  Created by Mohammad Ashraful Kabir on 02/02/2022.
//

import XCTest

class LaunchTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunches() throws {
        let expected = expectation(description: "Wait for n seconds")
        let apiHelper = APIHelper()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.LAUNCHES_ENDPOINT)"

        debugPrint("API URL: \(String(describing: urlComponents.url))")

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<[Launch], Error>) in
            switch result {
            case .success(let launches):
                debugPrint("We got a successful result with: \(launches)")
                XCTAssertNotNil(launches)
                
                var filteredLaunches: [Launch] = []
                
                var selectedYear = "" {
                    didSet {
                        filteredLaunches = launches.filter({
                            $0.dateUTC!.contains(selectedYear)
                            && (
                                ($0.success == nil && $0.upcoming == true)
                                || ($0.success == true && $0.upcoming == false)
                            )
                        })
                    }
                }
                
                selectedYear = "2000"
                XCTAssertTrue(filteredLaunches.count == 0, "No data available for year \(selectedYear)")
                
                selectedYear = "2020"
                let launch = filteredLaunches[0]
                XCTAssertNotNil(launch)
            case .failure(let error):
                debugPrint("We got a failure trying to get the launches. The error we got was: \(error.localizedDescription)")
                XCTAssertNotNil(error)
            }
            expected.fulfill()
        }
        self.wait(for: [expected], timeout: 30)
    }

}
