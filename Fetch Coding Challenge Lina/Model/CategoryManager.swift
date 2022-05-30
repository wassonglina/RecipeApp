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

    static func getCategoryData(url: String, completion: @escaping (Result<[CategoryItemModel], Error>) -> Void) {
        perform(urlString: url, transform: parseJSONCategory, completion: completion)
    }

    static func getRecipeData(url: String, completion: @escaping (Result<RecipeModel, Error>) -> Void) {
        perform(urlString: url, transform: parseJSONRecipe, completion: completion)
    }


    private static func perform<T>(urlString: String,
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

    private static func performNetworkRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
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
    static func parseJSONCategory(_ encodedData: Data) throws -> [CategoryItemModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: encodedData)
            let categoryModel: [CategoryItemModel] = decodedData.meals
                .map { CategoryItemModel(name: $0.strMeal, image: $0.strMealThumb, id: $0.idMeal) }
            return categoryModel
        }
    }

    //encode data for instructions
    static func parseJSONRecipe(_ encodedData: Data) throws -> RecipeModel {

        if let decodedData = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String : [[String : String?]]],
           let meals = decodedData["meals"],
           let meal = meals.first,
           let title = meal["strMeal"] as? String,
           let instruction = meal["strInstructions"] as? String,
           let image = meal["strMealThumb"] as? String {

            var i = 1
            var ings = [IngredientInfo]()

            while meal.index(forKey: "strIngredient\(i)") != nil  {
                if let ingredient = meal["strIngredient\(i)"] as? String,
                   let measurement = meal["strMeasure\(i)"] as? String,
                   !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    ings.append(IngredientInfo(ingredient: ingredient, measurement: measurement))
                }
                i += 1
                print(i)
            }
            return RecipeModel(name: title, instruction: instruction, image: image, ingredients: ings)
        }

        throw CategoryError.unexpectedFormat
    }
}


