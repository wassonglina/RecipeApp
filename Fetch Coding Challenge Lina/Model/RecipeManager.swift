//
//  RecipeManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

protocol RecipeManagerDelegate {
    func didFetchCategory(_ category: [RecipeModel])
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
                } else if let safeData = data, let categoryData = self.parseJSON(safeData) {
                    self.delegate?.didFetchCategory(categoryData)
                }
            }
        task.resume()
    }
    
    func parseJSON(_ recipesData: Data) -> [RecipeModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: recipesData)
            let recipeModels: [RecipeModel] = decodedData.meals
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
