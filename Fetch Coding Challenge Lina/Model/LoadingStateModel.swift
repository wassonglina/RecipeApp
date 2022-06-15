//
//  Created by Lina on 6/6/22.
//

import Foundation

enum LoadingState {
    case loading
    case loaded(name: String, image: String, ingredients: [IngredientInfo], instruction: String)
    case failed(String)
}

enum LoadingStateCategory {
    case loading
    case loaded([CategoryItemModel])
    case failed(String)
}
