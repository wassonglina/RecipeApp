//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func setState(state: LoadingState?)
}


class DetailViewModel {

    private let id: String
    weak var delegate: DetailViewModelDelegate?
    private var loadingState: LoadingState?     //make loading state optional unless state .loading will be initial state

    init(id: String) {
        self.id = id
    }

    func getRecipe() {
        NetworkManager.getRecipeData(id: id) { [weak self] in
            self?.evaluateResult(result: $0)
        }
        loadingState = .loading
        DispatchQueue.main.async {
            self.delegate?.setState(state: self.loadingState)
        }
    }

    private func evaluateResult(result: (Result<RecipeModel, NetworkError>)) {
        switch result {
        case .success(let recipeData):
            didFetchRecipe(recipeData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    private func didFetchRecipe(_ recipe: RecipeModel) {
        let name = recipe.name.capitalized
        let instruction = Self.sanitizeInstruction(with: recipe.instruction)

        loadingState = .loaded(name: name, image: recipe.image, ingredients: recipe.ingredients, instruction: instruction)

        DispatchQueue.main.async {
            self.delegate?.setState(state: self.loadingState)
        }
    }

    //static for test > move into seperate class with specific name (class MealSanitizer)
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

    func didCatchError(error: NetworkError) {
        let errorMessage: String

        switch error {
        case .invalidURL, .transformationError, .unexpectedNetworkResponse:
            errorMessage = "Something went wrong."
        case .urlSession(let nSError):
            errorMessage = nSError.localizedDescription
        }

        loadingState = .failed(errorMessage)

        DispatchQueue.main.async {
            self.delegate?.setState(state: self.loadingState)
        }
    }
}


