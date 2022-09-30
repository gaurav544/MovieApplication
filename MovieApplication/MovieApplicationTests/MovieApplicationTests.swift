//
//  MovieApplicationTests.swift
//  MovieApplicationTests
//
//  Created by Gaurav Arora on 9/28/22.
//

import XCTest
@testable import MovieApplication

class MovieApplicationTests: XCTestCase {
    var session: URLSession?

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieSearchApiCall() throws {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=5885c445eab51c7004916b9c0313e2d3&language=en-US&query=Star&page=1&include_adult=false"
        let expectation = expectation(description: "Status code: 200")
        guard let url = URL(string: urlString) else {
            XCTFail("Invalid URL")
            return
        }
        session?.dataTask(with: url) { _, response, error in
            if let error = error {
              XCTFail("Error: \(error.localizedDescription)")
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    expectation.fulfill()
                } else {
                  XCTFail("Status code: \(statusCode)")
                }
            }
        }.resume()
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testValidImagefromAPI() throws {
        let urlString = "https://image.tmdb.org/t/p/original/2SatEFCs04oFRqkZuY1fODYXeFI.jpg"
        let expectation = expectation(description: "Image is available for display")
        guard let url = URL(string: urlString) else {
            XCTFail("Invalid URL")
            return
        }
        session?.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if let _ = (response as? HTTPURLResponse)?.statusCode {
                if let data = data, let _ = UIImage(data: data) {
                    expectation.fulfill()
                } else {
                  XCTFail("Invalid image URL or corrupted image")
                }
            } else {
                    XCTFail("Status code unknown")
            }
        }.resume()
        wait(for: [expectation], timeout: 30)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
