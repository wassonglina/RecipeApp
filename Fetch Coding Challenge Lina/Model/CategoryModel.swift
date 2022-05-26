//
//  CategoryModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct CategoryModel: Hashable {

    let dessertName: String
//    let image: imge
    let id: String  //TODO: or type Int?
}


struct RecipeModel {

    let dessertName: String
    let id: String
    let instruction: String

    let ingredient1: String
    let ingredient2: String
    let ingredient3: String

    let measurement1: String
    let measurement2: String
    let measurement3: String
}
