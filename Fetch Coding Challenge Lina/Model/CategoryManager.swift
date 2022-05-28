//
//  CategoryManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

enum CategoryError: Error {
    case unexpectedFormat
}

struct CategoryManager {

    func getCategoryData(url: String, completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        perform(urlString: url, transform: parseJSONCategory, completion: completion)
    }

    func getRecipeData(url: String, completion: @escaping (Result<RecipeModel, Error>) -> Void) {
        perform(urlString: url, transform: parseJSONRecipe, completion: completion)
    }


    private func perform<T>(urlString: String,
                            transform: @escaping (Data) throws -> T,
                            completion: @escaping (Result<T, Error>) -> Void
    ) {
        performNetworkRequest(with: urlString) { result in

            switch result {
            case .success(let data):        // Network request successful
                do {
                    let entity = try transform(data)  //transform calls parseJSON
                    completion(.success(entity))      //if parsing success > data passed on
                } catch {
                    completion(.failure(error))     //if parsing failure > throws error
                    print("Error parsing JSON: \(error)")
                }
            case .failure(let error):       //Network request not succesful
                completion(.failure(error))
            }
        }
    }

    private func performNetworkRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        //return failure or throw in future version
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let safeData = data {
                    completion(.success(safeData))
                }
            }
        task.resume()
    }

    // encode data for category
    private func parseJSONCategory(_ encodedData: Data) throws -> [CategoryModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: encodedData)
            let categoryModel: [CategoryModel] = decodedData.meals
                .compactMap { CategoryModel(name: $0.strMeal, id: $0.idMeal) }
            return categoryModel
        }
    }

    //encode data for instructions
    private func parseJSONRecipe(_ encodedData: Data) throws -> RecipeModel {

        if let decodedData = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String : [[String : String?]]] {

            print(decodedData)

            if let meals = decodedData["meals"], let meal = meals.first, let title = meal["strMeal"] as? String, let instruction = meal["strInstructions"] as? String {     //as? takes away both optionals
                let ingredients = (1...20)
                    .compactMap { (meal["strIngredient\($0)"], meal["strMeasure\($0)"]) as? (String, String) }
                    .filter { $0 != ("", "") }       //check if always > no strIngredient & no strMeasure

                return RecipeModel(name: title, instruction: instruction, ingredients: ingredients)
            }
        }
        throw CategoryError.unexpectedFormat
    }
}
