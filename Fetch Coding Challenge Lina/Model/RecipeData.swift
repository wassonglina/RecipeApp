//
//  RecipeData.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct RecipeData: Codable {
    let meals: [Meals]
}

struct Meals: Codable {
    let strMeal: String
//    let strMealThumb: String      //TODO: How decode images?
    let idMeal: String
}

//    "strMeal": "Apam balik",
//    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
//    "idMeal": "53049"
