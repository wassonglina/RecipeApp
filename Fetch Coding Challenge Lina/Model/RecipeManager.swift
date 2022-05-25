//
//  RecipeManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

protocol RecipeManagerDelegate {
    func didFetchRecipes(recipes: RecipeModel)
    func didCatchError(error: Error)
}

struct RecipeManager {
    
    let categoryDessertURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"

    var delegate: RecipeManagerDelegate?        //no weak because struct?
    
    func performNetworkRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            print(session)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error performing network request.")
                    self.delegate?.didCatchError(error: error!)
                    return
                }
                if let safeData = data {
                    if let dessertRecipes = self.parseJSON(safeData) {
                        self.delegate?.didFetchRecipes(recipes: dessertRecipes)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ recipesData: Data) -> RecipeModel? {       //return Model      
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipesData)  //RecipeData
            let name = decodedData.meals[0].strMeal
            let id = decodedData.meals[0].idMeal
            let recipe = RecipeModel(dessertName: name, id: id)
            print(#function, recipe)
            return recipe
        } catch {
            self.delegate?.didCatchError(error: error)
            print("Error parsing JSON")
            return nil
        }
    }
}



//    let recipeURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
//    let letrecipeIDURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)"
//    let recipeID = //passed in via user selection
