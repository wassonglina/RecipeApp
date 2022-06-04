//
//  CategoryManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

enum NetworkError: Error {
    case unexpectedFormat
    case invalidURL
 //   case unexpectedNetworkResponse      //added later

}

struct NetworkManager {

    //static bc test > could move to seperate struct
    static func getCategoryData(completion: @escaping (Result<[CategoryItemModel], Error>) -> Void) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        perform(urlString: url, transform: parseJSONCategory, completion: completion)
    }

    static func getRecipeData(id: String, completion: @escaping (Result<RecipeModel, Error>) -> Void) {
        let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        perform(urlString: url, transform: parseJSONRecipe, completion: completion)
    }


    private static func perform<T>(urlString: String,
                                   transform: @escaping (Data) throws -> T,     //takes data and returns model > what parseJson does
                                   completion: @escaping (Result<T, Error>) -> Void
    ) {
        performNetworkRequest(with: urlString) { result in          //result in new completion handler passed into persormNETrequest

            switch result {
            case .success(let data):
                do {
                    let entity = try transform(data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))  //viewmodel evaluate result with error
            }
        }
    }

    private static func performNetworkRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let safeData = data {
                    completion(.success(safeData))
                }
              //  completion(.failure(unexpectedNetworkResponse))       added later
            }
        task.resume()
    }

    //static bc test
    static func parseJSONCategory(_ encodedData: Data) throws -> [CategoryItemModel] {
        let decoder = JSONDecoder()
//        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: encodedData)
            let categoryModels: [CategoryItemModel] = decodedData.meals
                .map { CategoryItemModel(name: $0.strMeal, image: $0.strMealThumb, id: $0.idMeal) }
            return categoryModels
  //      }
    }

    static func parseJSONRecipe(_ encodedData: Data) throws -> RecipeModel {

        print(encodedData)

        // JSONSerialization returns Any > to access Data need be turned into specific types
        // breakpoint with access to encodedData
        // type in console: po try JSONSerialization.jsonObject(with: encodedData, options: []) as? Any    (type "up")
        // as? [ String : Any ]
        // as? [ String : [Any] ]
        // as? [ String : [[String : Any]] ]
        // as? [ String : [[String : String?]] ]  > optional String because some hold nil (null)

        if let decodedData = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String : [[String : String?]]],

            let meals = decodedData["meals"],            //dictionary > return optional array meals > if let makes non optional > exists if nil
           let meal = meals.first,      //array     > if let makes non optional > exists if nil
           let title = meal["strMeal"] as? String,      //dictionary  > if let makes non optional > exists if nil  >> key gets optional optional string > and typecasting to String
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
            print(decodedData)
            return RecipeModel(name: title, instruction: instruction, image: image, ingredients: ings)
        }

        throw NetworkError.unexpectedFormat
    }
}


