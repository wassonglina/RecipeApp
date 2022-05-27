//
//  CategoryModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct CategoryModel: Hashable {
    let name: String
//    let image: imge
    let id: String  //TODO: or type Int?
}


struct RecipeModel {
    let name: String
    let instruction: String

    let ingredients: [(String, String)]
}
