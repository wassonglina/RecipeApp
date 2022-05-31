//
//  CategoryViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol CategoryViewModelDelegate: AnyObject {
    func prepareCategoryUI(with category: [CategoryItemModel])
    func didCatchError(error: Error)
}

class CategoryViewModel {

    private let categoryURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    weak var delegate: CategoryViewModelDelegate?

    func getCategoryData() {
        NetworkManager.getCategoryData(url: categoryURL) {
            self.evaluateResult(result: $0)
        }
    }

    func evaluateResult(result: (Result<[CategoryItemModel], Error>)) {
        switch result {
        case .success(let categoryData):
            didFetchCategory(categoryData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    func didFetchCategory(_ category: [CategoryItemModel]) {
        let sortedCategory = category
            .sorted { $0.name < $1.name }

        DispatchQueue.main.async {
            self.delegate?.prepareCategoryUI(with: sortedCategory)
        }
    }

    func didCatchError(error: Error) {
        // display error depending on future UX choices (convert to string, etc ...)
        self.delegate?.didCatchError(error: error)
    }
}

