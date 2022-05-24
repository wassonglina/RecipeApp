//
//  DetailViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {

    static let identifier = "cell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .yellow

        let recipeImageView = UIImageView()
        contentView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.image = UIImage(systemName: "sun.max")

        let recipeLabel = UILabel()
        contentView.addSubview(recipeLabel)
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.font = .boldSystemFont(ofSize: 20)
        recipeLabel.text = "It's a sunny day!"

        NSLayoutConstraint.activate([
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),

            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
       //     recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            recipeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 30),
            recipeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
