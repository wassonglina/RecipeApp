//
//  CategoryManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

protocol CategoryManagerDelegate {
    func didFetchCategory(_ category: [CategoryModel])
    func didCatchError(error: Error)
}

struct CategoryManager {

    var delegate: CategoryManagerDelegate?

    func getData(url: String, completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        perform(urlString: url, transform: parseJSON, completion: completion)
    }

    func perform(urlString: String,
                 transform: @escaping (Data) throws -> [CategoryModel],
                 completion: @escaping (Result<[CategoryModel], Error>) -> Void
    ) {
        performNetRequest(with: urlString) { result in

            switch result {
            case .success(let data):        // Network request successful
                do {
                    let entity = try transform(data)  //transform calls parseJSONCurrent or parseJSONForecast
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

    //use completion instead of delegate
    func performNetRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {

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


//    func performNetworkRequest(with urlString: String) {
//        //return failure or throw in future version
//        guard let url = URL(string: urlString) else { return }
//        let task = URLSession.shared
//            .dataTask(with: url) { data, response, error in
//                if let error = error {
//                    self.delegate?.didCatchError(error: error)
//                } else if let safeData = data, let categoryData = self.parseJSON(safeData) {
//                    self.delegate?.didFetchCategory(categoryData)
//                }
//            }
//        task.resume()
//    }

    //    func requestForecastGeoURL(with coordinates: CLLocationCoordinate2D, completion: @escaping (Result<[ForecastModel], Error>) -> Void) {
    //        let forecastURLString = "\(weatherForecastURL)&appid=\(id)&lat=\(coordinates.latitude)&lon=\(coordinates.longitude)"
    //        perform(urlString: forecastURLString, transform: parseJSONForecast, completion: completion)
    //    }

    
    func parseJSON(_ encodedData: Data) throws -> [CategoryModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: encodedData)
            let categoryModel: [CategoryModel] = decodedData.meals
                .compactMap { CategoryModel(dessertName: $0.strMeal, id: $0.idMeal) }
            return categoryModel
        }
//        catch {
//            self.delegate?.didCatchError(error: error)
//            return nil
//        }
    }
}


//    let recipeURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
//    let letrecipeIDURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)"
//    let recipeID = //passed in via user selection
