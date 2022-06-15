//
//  Created by Lina on 5/30/22.
//

import Foundation

struct RecipeModel: Equatable {
    let name: String
    let instruction: String
    let image: String

    // originally was using a tuple, but tuples are not equatable
    // so this is one solution instead of manually equating tuple's content
    let ingredients: [IngredientInfo]
}

struct IngredientInfo: Equatable {
    let ingredient: String
    let measurement: String
}
