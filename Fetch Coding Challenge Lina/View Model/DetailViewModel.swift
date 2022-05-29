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
        //TODO: doesn't work
        let instruction = recipe.instruction
            .replacingOccurrences(of: "\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n\r\n", with: "\n\n")
            .replacingOccurrences(of: "\r\n\r\n\r\n", with: "\n\n")

        //TODO: doesn't work either
//        let replacements = [
//            ("\r\n", "\n\n"),
//            ("\r\n\r\n", "\n\n"),
//            ("\r\n\r\n\r\n", "\n\n")
//        ]
//
//        var instruction2 = recipe.instruction
//
//        for (searchString, replacement) in replacements {
//            instruction2 = instruction2.replacingOccurrences(of: searchString, with: replacement)
//        }

        print(instruction)

        self.delegate?.prepareDetailUI(name: recipe.name, image: recipe.image, ingredients: recipe.ingredients, instruction: instruction)
    }

    func didCatchError(error: Error) {
        // display error with this string
        self.delegate?.didCatchError(error: error)
    }
}


// \r\n\r\n

