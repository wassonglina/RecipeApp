//
//  CategoryManager.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/25/22.
//

import Foundation

struct CategoryManager {

    func getData(url: String, completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        perform(urlString: url, transform: parseJSON, completion: completion)
    }

    func perform(urlString: String,
                 transform: @escaping (Data) throws -> [CategoryModel],
                 completion: @escaping (Result<[CategoryModel], Error>) -> Void
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

    func performNetworkRequest(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
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
    
    func parseJSON(_ encodedData: Data) throws -> [CategoryModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryPayload.self, from: encodedData)
            let categoryModel: [CategoryModel] = decodedData.meals
                .compactMap { CategoryModel(dessertName: $0.strMeal, id: $0.idMeal) }
            return categoryModel
        }
    }
}
