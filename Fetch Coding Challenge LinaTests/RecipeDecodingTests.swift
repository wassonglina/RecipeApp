//
//  Fetch_Coding_Challenge_LinaTests.swift
//  Fetch Coding Challenge LinaTests
//
//  Created by Lina on 5/24/22.
//

import XCTest
@testable import Fetch_Coding_Challenge_Lina

class RecipeDecodingTests: XCTestCase {

    func testSimpleSucces() throws {
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Battenberg Cake",
                    "strInstructions": "My instructions.",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
                    "strIngredient1": "Butter",
                    "strIngredient2": "Caster Sugar",
                    "strMeasure1": "175g",
                    "strMeasure2": "210",
                }
            ]
        }
"""
        let data = json.data(using: .utf8)!
        let decodedResult = try NetworkManager.parseJSONRecipe(data)
        let result = RecipeModel(name: "Battenberg Cake", instruction: "My instructions.", image: "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg", ingredients: [
            IngredientInfo(ingredient: "Butter", measurement: "175g"),
            IngredientInfo(ingredient: "Caster Sugar", measurement: "210")
        ])
        XCTAssertEqual(decodedResult, result)
    }

    func testFilteringInvalidIngredients() throws {
        let json = """
        {
            "meals": [
                {
                    "strMeal": "Battenberg Cake",
                    "strInstructions": "My instructions.",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
                    "strIngredient1": "Butter",
                    "strIngredient2": "Test Test",
                    "strIngredient3": "Caster Sugar",
                    "strIngredient4": "",
                    "strMeasure1": "175g",
                    "strMeasure2": " ",
                    "strMeasure3": "210g",
                    "strMeasure4": "175g"
                }
            ]
        }
"""
        let data = json.data(using: .utf8)!
        let decodedResult = try NetworkManager.parseJSONRecipe(data)
        let result = RecipeModel(name: "Battenberg Cake", instruction: "My instructions.", image: "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg", ingredients: [
            IngredientInfo(ingredient: "Butter", measurement: "175g"),
            IngredientInfo(ingredient: "Caster Sugar", measurement: "210g")
        ])
        XCTAssertEqual(decodedResult, result)
    }

    func testInvalidMeal() throws {
        let json = """
    {
        "meals": [
            {
                "strInstructions": "My instructions.",
                "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
                "strIngredient1": "Butter",
                "strIngredient2": "Caster Sugar",
                "strMeasure1": "175g",
                "strMeasure2": "210g"
            }
        ]
    }
"""
        let data = json.data(using: .utf8)!
        XCTAssertThrowsError(try NetworkManager.parseJSONRecipe(data))
    }
}




