//
//  CategoryData.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct CategoryPayload: Codable {
    let meals: [Meals]

    struct Meals: Codable {
        let strMeal: String
        //    let strMealThumb: String      //TODO: How decode images?
        let idMeal: String
    }
}

struct RecipePayload: Codable {

    let meals: [Recipe]

    struct Recipe: Codable {
        //meal and id shouldn't change > get again?
        let idMeal: String
        let strMeal: String
        let strInstructions: String
        let strIngredient1: String
        let strIngredient2: String
        let strIngredient3: String
        // ... 20

        let strMeasure1: String
        let strMeasure2: String
        let strMeasure3: String
        // ... 20
    }
}


