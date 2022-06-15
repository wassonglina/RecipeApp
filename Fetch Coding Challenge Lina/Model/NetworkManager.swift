//
//  Created by Lina on 5/25/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case transformationError
    case urlSession(NSError)
    case unexpectedNetworkResponse

}

struct NetworkManager {

    //static for test > could move into seperate struct
    static func getCategoryData(completion: @escaping (Result<[CategoryItemModel], NetworkError>) -> Void) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        perform(urlString: url, transform: parseJSONCategory, completion: completion)
    }

    static func getRecipeData(id: String, completion: @escaping (Result<RecipeModel, NetworkError>) -> Void) {
        let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        perform(urlString: url, transform: parseJSONRecipe, completion: completion)
    }


    private static func perform<T>(urlString: String,
                                   transform: @escaping (Data) throws -> T, 
                                   completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        performNetworkRequest(with: urlString) { result in

            switch result {
            case .success(let data):
                do {
                    let entity = try transform(data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(NetworkError.transformationError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private static func performNetworkRequest(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    let networkError = NetworkError.urlSession(error as NSError) //cast as NSError (not as?) bc not failable
                    completion(.failure(networkError))
                } else if let safeData = data {
                    completion(.success(safeData))
                } else {
                    completion(.failure(NetworkError.unexpectedNetworkResponse))
                }
            }
        task.resume()
    }

    //static for test
    static func parseJSONCategory(_ encodedData: Data) throws -> [CategoryItemModel] {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(CategoryPayload.self, from: encodedData)
        let categoryModels: [CategoryItemModel] = decodedData.meals
            .map { CategoryItemModel(name: $0.strMeal, image: $0.strMealThumb, id: $0.idMeal) }
        return categoryModels
    }

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
            }
            return RecipeModel(name: title, instruction: instruction, image: image, ingredients: ings)
        }
        throw NetworkError.transformationError
    }
}


