//
//  RecipeTableViewCell.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//
import UIKit
import Kingfisher


class RecipeTableViewCell: UITableViewCell {

    static let identifier = "cell"
    private let categoryRecipeLabel = UILabel()
    private let categoryImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(categoryImageView)
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(categoryRecipeLabel)
        categoryRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryRecipeLabel.font = .boldSystemFont(ofSize: 20)
        categoryRecipeLabel.numberOfLines = 0

        let verticalPadding = 15.0
        let horizontalPadding = 40.0

        let heightConstraint = categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor)
        heightConstraint.priority = .defaultHigh        //set to .defaultHigh priority otherweise conflicting constraints in cell

        NSLayoutConstraint.activate([
            categoryImageView.widthAnchor.constraint(equalToConstant: 90),
            heightConstraint,
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),

            categoryRecipeLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 25),
            categoryRecipeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //set title of each cell
    func setTitle(with title: String) {
        categoryRecipeLabel.text = title
    }

    //TODO: make image load faster when scrolling fast
    func setImage(with stringURL: String) {
        let url = URL(string: stringURL)
        categoryImageView.kf.setImage(with: url)
    }
}


