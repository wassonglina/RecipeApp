//
//  RecipeManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

protocol RecipeManagerDelegate {
    func didFetchCategory(_ recipes: [RecipeModel])
    func didCatchError(error: Error)
}

struct RecipeManager {

    var delegate: RecipeManagerDelegate?
    
    func performNetworkRequest(with urlString: String) {
        //return failure or throw in future version
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    self.delegate?.didCatchError(error: error)
                } else if let safeData = data, let recipesData = self.parseJSON(safeData) {
                    self.delegate?.didFetchCategory(recipesData)
                }
            }
        task.resume()
    }
    
    func parseJSON(_ recipesData: Data) -> [RecipeModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: recipesData)
            //TODO: sort data here? use map or compactMap?
            let recipeModels: [RecipeModel] = decodedData.meals
            //move view model
                .sorted { $0.strMeal < $1.strMeal }
                .compactMap { RecipeModel(dessertName: $0.strMeal, id: $0.idMeal) }
            return recipeModels
        } catch {
            self.delegate?.didCatchError(error: error)
            return nil
        }
    }
}



//    let recipeURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
//    let letrecipeIDURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)"
//    let recipeID = //passed in via user selection
