//
//  Fetch_Coding_Challenge_LinaTests.swift
//  Fetch Coding Challenge LinaTests
//
//  Created by Lina on 5/24/22.
//

import XCTest
@testable import Fetch_Coding_Challenge_Lina

class Fetch_Coding_Challenge_LinaTests: XCTestCase {



    func testSanitizeRecipes() throws {

        let json = """
        {
            "meals": [
                {
                    "idMeal": "52894",
                    "strMeal": "Battenberg Cake",
                    "strInstructions": "My instructions.",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
                    "strIngredient1": "Butter",
                    "strIngredient2": "Caster Sugar",
                    "strMeasure1": "175g",
                    "strMeasure2": "175g",
                }
            ]
        }
"""


        let data = json.data(using: .utf8)!

        let decodedResult = try CategoryManager.parseJSONRecipe(data)

        let result = RecipeModel(name: "Battenberg Cake", instruction: "My instructions.", image: "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg", ingredients: [
            IngredientInfo(ingredient: "Butter", measurement: "175g"),
            IngredientInfo(ingredient: "Caster Sugar", measurement: "175g")
        ])

        XCTAssertEqual(decodedResult, result)

    }
}




