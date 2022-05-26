//
//  CategoryViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func prepareCategoryUI(with category: [RecipeModel])
    func didCatchError(error: Error)
}

class CategoryViewModel: RecipeManagerDelegate {

    private let recipeURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"

    weak var delegate: ViewModelDelegate?
    var recipeManager = RecipeManager()

    init() {
        recipeManager.delegate = self
    }

    func getCategoryData() {
        recipeManager.performNetworkRequest(with: recipeURL)

    }

    func didFetchCategory(_ category: [RecipeModel]) {
        self.delegate?.prepareCategoryUI(with: category)
        print(category)
    }

    func didCatchError(error: Error) {
        self.delegate?.didCatchError(error: error)
        print(error)
    }
}

