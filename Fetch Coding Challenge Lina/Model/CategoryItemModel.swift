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


struct RecipeModel {
    let name: String
    let instruction: String
    let image: String
    let ingredients: [(String, String)]
}
