//
//  DetailViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func prepareDetailUI(name: String, image: String, ingredients: [IngredientInfo], instruction: String)
    func didCatchError(error: Error)
}

class DetailViewModel {

    private let id: String
    weak var delegate: DetailViewModelDelegate?

    init(id: String) {
        self.id = id
    }

    func getRecipe() {
        NetworkManager.getRecipeData(id: id) { [weak self] in
            self?.evaluateResult(result: $0)
        }
    }

    //private
    func evaluateResult(result: (Result<RecipeModel, Error>)) {
        switch result {
        case .success(let recipeData):
            didFetchRecipe(recipeData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    //private
    func didFetchRecipe(_ recipe: RecipeModel) {
        let name = recipe.name.capitalized
        let instruction = Self.sanitizeInstruction(with: recipe.instruction)

        //prepare so everything is on main thread for UI
        DispatchQueue.main.async {
            self.delegate?.prepareDetailUI(name: name, image: recipe.image, ingredients: recipe.ingredients, instruction: instruction)
        }
    }

    //static because public for test > move into seperate class with specific name (class MealSanitizer)
    static func sanitizeInstruction(with instruction: String) -> String {

        //strange line seperator some recipes use: U+2028
        //print e.g. Classic Christmas Pudding instrcution, copy last to first character into  https://unicode-table.com/en/2028/
        let lineSeperator = " "

        return instruction
            .replacingOccurrences(of: "\r\n\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n", with: "\n\n")
            .replacingOccurrences(of: lineSeperator, with: "")

        //more things to potentially standardize (like step numbers)
        //intentionally didn't remove existing step numbers as this made recipes confusing (e.g. Portuguese Custard Tarts)
    }

    func didCatchError(error: Error) {
        // display error depending on future UX choices (convert to string, etc ...)
        print(String(describing: error))
        // get error code to print localized error desciption: Code=-1009 "The Internet connection appears to be offline."
        self.delegate?.didCatchError(error: error)
    }
}


