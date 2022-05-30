//
//  DetailViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func prepareDetailUI(name: String, image: String, ingredients: [(String, String)], instruction: String)
    func didCatchError(error: Error)
}


class DetailViewModel {

    private let InstructionUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="

    private let id: String

    //TODO: instanciate new CategoryManager()? with let
    let categoryManager = CategoryManager()

    weak var delegate: DetailViewModelDelegate?

    init(id: String) {
        self.id = id
    }

    func getRecipe() {
        let instructionURL = "\(InstructionUrl)\(id)"
        categoryManager.getRecipeData(url: instructionURL) { [self] recipe in
            evaluateResult(result: recipe)
        }
    }

    //TODO: Repeat (in CategoryViewModel)
    func evaluateResult(result: (Result<RecipeModel, Error>)) {
        switch result {
        case .success(let recipeData):
            didFetchRecipe(recipeData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    func didFetchRecipe(_ recipe: RecipeModel) {
        //do any additional preparation on category for UI in here, then pass to VC

        let name = recipe.name.capitalized

        //strange line seperator some recipes use: U+2028
        let lineSeperator = " "

        let instruction = recipe.instruction
            .replacingOccurrences(of: "\r\n\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n", with: "\n\n")
            .replacingOccurrences(of: lineSeperator, with: "")

        print(instruction)

        DispatchQueue.main.async {
            self.delegate?.prepareDetailUI(name: name, image: recipe.image, ingredients: recipe.ingredients, instruction: instruction)
        }
    }

    func didCatchError(error: Error) {
        // display error with this string
        self.delegate?.didCatchError(error: error)
    }
}


