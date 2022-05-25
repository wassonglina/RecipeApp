//
//  RecipeTableViewCell.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Foundation
import UIKit

class RecipeTableViewCell: UITableViewCell {

    static let identifier = "cell"

     let categoryRecipeLabel = UILabel()
    private let categoryImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .lightGray

        contentView.addSubview(categoryImageView)
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.image = UIImage(systemName: "sun.max")
        categoryImageView.contentMode = .scaleAspectFit


        contentView.addSubview(categoryRecipeLabel)
        categoryRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryRecipeLabel.font = .boldSystemFont(ofSize: 20)  //make font adjustable to label length
        categoryRecipeLabel.text = "Yummy Chocolate Cake"

        NSLayoutConstraint.activate([
            categoryImageView.widthAnchor.constraint(equalToConstant: 80),
            //     categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor),       //TODO: conflicting width constraint??
            categoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            //     recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            categoryRecipeLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 15),
            categoryRecipeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getRecipeLabel(name: String) {
   //     categoryRecipeLabel.text = name
    }
}


