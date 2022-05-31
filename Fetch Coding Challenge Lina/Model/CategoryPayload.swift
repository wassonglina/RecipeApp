//
//  CategoryPayload.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct CategoryPayload: Codable {
    let meals: [Meals]

    struct Meals: Codable {
        let strMeal: String
        let strMealThumb: String
        let idMeal: String
    }
}
