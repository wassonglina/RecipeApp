//
//  DetailViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import UIKit

class DetailViewController: UIViewController {

    let dummyInstruction = "Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.\r\nCream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling."

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange

        let detailRecipeLabel = UILabel()
        view.addSubview(detailRecipeLabel)
        detailRecipeLabel.font = .boldSystemFont(ofSize: 24)
        detailRecipeLabel.text = "Chocolate Cake"
        detailRecipeLabel.translatesAutoresizingMaskIntoConstraints = false

        //TODO: make scrollable
        let instructionLabel = UILabel()
        view.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.font = .systemFont(ofSize: 17)
        instructionLabel.text = dummyInstruction
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.numberOfLines = 0

        let detailImageView = UIImageView()
        view.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.image = UIImage(systemName: "sun.max")
        detailImageView.contentMode = .scaleAspectFit

        //stack view
        

        NSLayoutConstraint.activate([
            detailRecipeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailRecipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailImageView.topAnchor.constraint(equalTo: detailRecipeLabel.bottomAnchor, constant: 80),
            detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailImageView.widthAnchor.constraint(equalToConstant: 100),
            detailImageView.heightAnchor.constraint(equalTo: detailImageView.widthAnchor),

            instructionLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 40),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
