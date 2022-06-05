//
//  CategoryViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol CategoryViewModelDelegate: AnyObject {
    func prepareCategoryUI(with category: [CategoryItemModel])
    func didCatchError(message: String)
}

class CategoryViewModel {

    weak var delegate: CategoryViewModelDelegate?

    func getCategoryData() {
        NetworkManager.getCategoryData { [weak self] in
            self?.evaluateResult(result: $0)
        }
    }

    func evaluateResult(result: (Result<[CategoryItemModel], NetworkError>)) {
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

    func didCatchError(error: NetworkError) {

        let errorMessage: String

        switch error {
        case .unexpectedFormat, .invalidURL, .transformationError:
            errorMessage = "Something went wrong."
        case .urlSession(let nsError):
            errorMessage = nsError.localizedDescription
        }

        DispatchQueue.main.async {
        self.delegate?.didCatchError(message: errorMessage)
        }
        // display error depending on future UX choices (convert to string, etc ...)

    }
}

