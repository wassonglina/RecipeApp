//
//  DetailViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func prepareDetailUI(with recipe: [RecipeModel])
    func didCatchError(error: Error)
}


class DetailViewModel {

    private let InstructionUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="

//TODO: instanciate new CategoryManager()? with let
    let categoryManager = CategoryManager()

    weak var delegate: DetailViewModelDelegate?

    func getRecipeForID(id: String) {
        let instructionURL = "\(InstructionUrl)\(id)"
        categoryManager.getRecipeData(url: instructionURL) { [self] recipe in
            evaluateResult(result: recipe)
        }
    }

    //TODO: Repeat (in CategoryViewModel)
    func evaluateResult(result: (Result<[RecipeModel], Error>)) {
        switch result {
        case .success(let recipeData):
            didFetchRecipe(recipeData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    func didFetchRecipe(_ recipe: [RecipeModel]) {
        //do any additional preparation on category for UI in here, then pass to VC
//        let sortedRecipe: [RecipeModel] = recipe.filter {
//            $0 != ""
//        }
        print(#function)
        print(delegate)
        self.delegate?.prepareDetailUI(with: recipe)
    }

    func didCatchError(error: Error) {
        self.delegate?.didCatchError(error: error)
    }
}
