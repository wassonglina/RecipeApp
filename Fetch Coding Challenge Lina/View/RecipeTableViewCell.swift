//
//  RecipeTableViewCell.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Kingfisher
import UIKit

class RecipeTableViewCell: UITableViewCell {

    static let identifier = "cell"
    private let categoryRecipeLabel = UILabel()
    private let categoryImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(categoryImageView)
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false

        let url = URL(string: "https://www.themealdb.com/images/media/meals/yqqqwu1511816912.jpg")
        categoryImageView.kf.setImage(with: url)

//        categoryImageView.contentMode = .scaleAspectFit

        contentView.addSubview(categoryRecipeLabel)
        categoryRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryRecipeLabel.font = .boldSystemFont(ofSize: 20)  //TODO: make font adjustable to label length
        let heightConstraint = categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor)
        heightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            categoryImageView.widthAnchor.constraint(equalToConstant: 80),
            heightConstraint,
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

    //set title of each cell
    func setTitle(_ title: String) {
        categoryRecipeLabel.text = title
    }
}


