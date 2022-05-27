//
//  CategoryViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol CategoryViewModelDelegate: AnyObject {
    func prepareCategoryUI(with category: [CategoryModel])
    func didCatchError(error: Error)
}

class CategoryViewModel {

    private let categoryURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"

    weak var delegate: CategoryViewModelDelegate?
    var categoryManager = CategoryManager()

    //TODO: where to call self > [self] or self.evaluateResult
    func getCategoryData() {
        categoryManager.getCategoryData(url: categoryURL) { [self] category in
            evaluateResult(result: category)
        }
    }

    func evaluateResult(result: (Result<[CategoryModel], Error>)) {
        switch result {
        case .success(let categoryData):
            didFetchCategory(categoryData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    func didFetchCategory(_ category: [CategoryModel]) {
        //do any additional preparation on category for UI in here, then pass to VC
        let sortedCategory: [CategoryModel] = category.sorted { $0.dessertName < $1.dessertName }
        self.delegate?.prepareCategoryUI(with: sortedCategory)
    }

    func didCatchError(error: Error) {
        self.delegate?.didCatchError(error: error)
    }
}

