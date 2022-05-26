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

struct DetailsPayload: Codable {

    let strMeal: String
    let strInstructions: String
    let strIngredient1: String
    // 2,3,4 ...
    let strMeasure1: String
    // 2,3,4 ...

}


//make comment why use two diff structs


//"strIngredient1": "Milk",
//"strIngredient2": "Oil",
//"strIngredient3": "Eggs",
//"strIngredient4": "Flour",
//"strIngredient5": "Baking Powder",
//"strIngredient6": "Salt",
//"strIngredient7": "Unsalted Butter",
//"strIngredient8": "Sugar",
//"strIngredient9": "Peanut Butter",
//"strIngredient10": "",
//"strIngredient11": "",
//"strIngredient12": "",
//"strIngredient13": "",
//"strIngredient14": "",
//"strIngredient15": "",
//"strIngredient16": "",
//"strIngredient17": "",
//"strIngredient18": "",
//"strIngredient19": "",
//"strIngredient20": "",


//"strMeasure1": "½ cup ",
//"strMeasure2": "1 cup ",
//"strMeasure3": "2",
//"strMeasure4": "1 tsp ",
//"strMeasure5": "2 cups ",
//"strMeasure6": "1 tsp ",
//"strMeasure7": "1 1/4 cup",
//"strMeasure8": "1 1/2 cup ",
//"strMeasure9": "1 1/2 cup ",
//"strMeasure10": "1 1/2 cup ",
//"strMeasure11": "1/3 cup",
//"strMeasure12": "",
//"strMeasure13": "",
//"strMeasure14": "",
//"strMeasure15": "",
//"strMeasure16": "",
//"strMeasure17": "",
//"strMeasure18": "",
//"strMeasure19": "",
//"strMeasure20": "",
