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
        NetworkManager.getRecipeData(id: id) { result in
            self.evaluateResult(result: result)
        }
    }

    func evaluateResult(result: (Result<RecipeModel, Error>)) {
        switch result {
        case .success(let recipeData):
            didFetchRecipe(recipeData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    func didFetchRecipe(_ recipe: RecipeModel) {
        let name = recipe.name.capitalized
        let instruction = Self.sanitizeInstruction(with: recipe.instruction)

        DispatchQueue.main.async {
            self.delegate?.prepareDetailUI(name: name, image: recipe.image, ingredients: recipe.ingredients, instruction: instruction)
        }
    }

    static func sanitizeInstruction(with instruction: String) -> String {

        //strange line seperator some recipes use: U+2028
        let lineSeperator = " "
        return instruction
            .replacingOccurrences(of: "\r\n\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n", with: "\n\n")
            .replacingOccurrences(of: lineSeperator, with: "")
    }

    func didCatchError(error: Error) {
        // display error depending on future UX choices (convert to string, etc ...)
        self.delegate?.didCatchError(error: error)
    }
}


