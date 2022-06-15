//
//  Created by Lina on 5/26/22.
//

import Foundation

protocol CategoryViewModelDelegate: AnyObject {
    func setState(state: LoadingStateCategory)
}

class CategoryViewModel {

    weak var delegate: CategoryViewModelDelegate?
    private var loadingState: LoadingStateCategory = .loading

    func getCategoryData() {
        NetworkManager.getCategoryData { [weak self] in
            self?.evaluateResult(result: $0)
        }
        loadingState = .loading
    }

    private func evaluateResult(result: (Result<[CategoryItemModel], NetworkError>)) {
        switch result {
        case .success(let categoryData):
            didFetchCategory(categoryData)
        case .failure(let error):
            didCatchError(error: error)
        }
    }

    private func didFetchCategory(_ category: [CategoryItemModel]) {
        let sortedCategory = category
            .sorted { $0.name < $1.name }

        loadingState = .loaded(sortedCategory)

        DispatchQueue.main.async {
            self.delegate?.setState(state: self.loadingState)
        }
    }


    private func didCatchError(error: NetworkError) {
        let errorMessage: String

        switch error {
        case .invalidURL, .transformationError, .unexpectedNetworkResponse:
            errorMessage = "Something went wrong."
        case .urlSession(let nsError):
            errorMessage = nsError.localizedDescription
        }

        loadingState = .failed(errorMessage)

        DispatchQueue.main.async {
            self.delegate?.setState(state: self.loadingState)
        }
    }
}

