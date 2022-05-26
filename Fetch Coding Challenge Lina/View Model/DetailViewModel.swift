//
//  DetailViewModel.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation


class DetailViewModel {

    private let InstructionUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="

//TODO: instanciate new CategoryManager()?
    let categoryManager = CategoryManager()

    func getRecipeForID(id: String) {
        let instructionURL = "\(InstructionUrl)\(id)"

        categoryManager.getRecipeData(url: instructionURL) { recipe in
            print(recipe)
        }
    }

    

}
