//
//  DetailViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//

import Foundation
import UIKit


class DetailViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        addScrollView()
        addStackView()
        addTitleLabel()
        addImageView()
        addIngredientsTitleLabel()
        addIngredientStackView()
        addInstructionTitleLabel()
        addInstructionsLabel()
    }

    private func addStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }

    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor), //read up on this
        ])
    }

    private func addTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Chocolate Cake"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.backgroundColor = .magenta
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
    }

    private func addImageView() {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        stackView.addArrangedSubview(imageView)
    }

    private func addIngredientsTitleLabel() {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = .boldSystemFont(ofSize: 19)
        ingredientsLabel.backgroundColor = .yellow
        stackView.addArrangedSubview(ingredientsLabel)
    }

    private func addIngredientStackView() {

        let ingredientStackView = UIStackView()
        stackView.addArrangedSubview(ingredientStackView)
        ingredientStackView.spacing = 25
        ingredientStackView.backgroundColor = .systemMint

        let measurementLabel = UILabel()
        ingredientStackView.addArrangedSubview(measurementLabel)
        measurementLabel.text = "Measurement"

        let ingredientLabel = UILabel()
        ingredientStackView.addArrangedSubview(ingredientLabel)
        ingredientLabel.text = "Ingredients"
    }

    private func addInstructionTitleLabel() {
        let instructionLabel = UILabel()
        instructionLabel.text = "Instructions"
        instructionLabel.font = .boldSystemFont(ofSize: 19)
        instructionLabel.backgroundColor = .yellow
        stackView.addArrangedSubview(instructionLabel)
    }

    private func addInstructionsLabel() {
        let instructionLabel = UILabel()
        instructionLabel.numberOfLines = 0
        stackView.addArrangedSubview(instructionLabel)
        instructionLabel.backgroundColor = .link
        instructionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -70).isActive = true  //TODO: check for landscape
        instructionLabel.text = "Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.\r\nCream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling. Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.\r\nCream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling. Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.\r\nCream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling. Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.\r\nCream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling."
    }
}

