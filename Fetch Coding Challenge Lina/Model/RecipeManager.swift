//
//  RecipeManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct RecipeManager {
    
    let categoryDessertURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func performNetworkRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            print(session)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error getting recipes.")
                    //self delegate got error
                    return
                }
                if let safeData = data {
                    parseJSON(safeData)
                    //                    if let dessertRecipes = self.parseJSON(safeData) {
                    //                    //    call delegate got recipes
                    //                        print("got data", safeData)
                    //                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ recipesData: Data) {       //return Model
        print("parsing JSON with", recipesData)
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipesData)  //RecipeData
            let name = decodedData.meals[0].strMeal
            let id = decodedData.meals[0].idMeal
            
            print(name, id)
            //return Model
        } catch {
            //call delegate got Error
            print("Error parsing JSON")
            // return Model
        }
    }
}



//    let recipeURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
//    let letrecipeIDURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)"
//    let recipeID = //passed in via user selection
