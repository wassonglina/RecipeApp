//
//  CategoryDecodingTest.swift
//  Fetch Coding Challenge LinaTests
//
//  Created by Lina on 5/30/22.
//

import XCTest
@testable import Fetch_Coding_Challenge_Lina

class CategoryDecodingTest: XCTestCase {

    func testSimpleSucces() throws {

        let json = """
        {
            "meals": [
                {
                    "strMeal": "Apam balik",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                    "idMeal": "53049"
                },
                {
                    "strMeal": "Apple & Blackberry Crumble",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
                    "idMeal": "52893"
                }
            ]
        }
"""

        let data = json.data(using: .utf8)!
        let decodedResult = try NetworkManager.parseJSONCategory(data)
        let result = [CategoryItemModel(name: "Apam balik", image: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", id: "53049"), CategoryItemModel(name: "Apple & Blackberry Crumble", image: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", id: "52893")]
        XCTAssertEqual(decodedResult, result)
    }

    func testInvalidCategory() throws {
        let json = """
        {
            "meals": [
                {
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                    "idMeal": "53049"
                }
            ]
        }
"""
        let data = json.data(using: .utf8)!
        XCTAssertThrowsError(try NetworkManager.parseJSONCategory(data))
    }
}


//TODO: Fix so that incomplete categories are not included but completed categories are
