//
//  CategoryModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct CategoryItemModel: Hashable {
    let name: String
    let image: String
    let id: String
}


struct RecipeModel: Equatable {

    let name: String
    let instruction: String
    let image: String
    let ingredients: [IngredientInfo]
}

//tuples are not equatable so this is one solution istead of manually equating  tuple's content
struct IngredientInfo: Equatable {
    let ingredient: String
    let measurement: String
}
