//
//  DetailViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import UIKit

//rename InstructionViewController
class DetailViewController2: UIViewController {

   private let dummyInstruction = "Pre-heat the oven to 180C/350F/Gas 4. Grease an 18cm/7in round cake tin, line the base with greaseproof paper and grease the paper.\r\nCream the butter and sugar together in a bowl until pale and fluffy. Beat in the eggs, one at a time, beating the mixture well between each one and adding a tablespoon of the flour with the last egg to prevent the mixture curdling."

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange

        let recipeTitleLabel = UILabel()
        view.addSubview(recipeTitleLabel)
        recipeTitleLabel.font = .boldSystemFont(ofSize: 24)
        recipeTitleLabel.text = "Chocolate Cake"
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false


        let instructionsLabel = UILabel()
        view.addSubview(instructionsLabel)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.font = .systemFont(ofSize: 17)
        instructionsLabel.text = dummyInstruction
        instructionsLabel.lineBreakMode = .byWordWrapping
        instructionsLabel.numberOfLines = 0

        let ingredientsTitleLabel = UILabel()
        view.addSubview(ingredientsTitleLabel)
        ingredientsTitleLabel.font = .boldSystemFont(ofSize: 20)
        ingredientsTitleLabel.text = "Ingredients"
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let instructionsTitleLabel = UILabel()
        view.addSubview(instructionsTitleLabel)
        instructionsTitleLabel.font = .boldSystemFont(ofSize: 20)
        instructionsTitleLabel.text = "Instructions"
        instructionsTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let detailImageView = UIImageView()
        view.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.image = UIImage(systemName: "sun.max")
        detailImageView.contentMode = .scaleAspectFit

        let ingredientsStackView = UIStackView()
        view.addSubview(ingredientsStackView)
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsStackView.backgroundColor = .lightGray
        ingredientsStackView.spacing = 20
        ingredientsStackView.axis = NSLayoutConstraint.Axis.horizontal
  //      ingredientsStackView.distribution = .equalSpacing
 //       ingredientsStackView.alignment = .center

        let ingredientsLabel = UILabel()
        ingredientsStackView.addArrangedSubview(ingredientsLabel)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.textAlignment = .left

        let measurementLabel = UILabel()
        ingredientsStackView.addArrangedSubview(measurementLabel)
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.text = "Measurement"
        measurementLabel.textAlignment = .left

        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            recipeTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 30),
            detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailImageView.widthAnchor.constraint(equalToConstant: 100),
            detailImageView.heightAnchor.constraint(equalTo: detailImageView.widthAnchor),

            ingredientsTitleLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 30),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),

            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 15),
//            ingredientsStackView.heightAnchor.constraint(equalToConstant: 250), //TODO: depends on ingredients contect
            ingredientsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ingredientsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ingredientsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

    //        ingredientsLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 20.0),

 //           measurementLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            measurementLabel.heightAnchor.constraint(equalToConstant: 20.0),

            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsStackView.bottomAnchor, constant: 30),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),

            instructionsLabel.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 15),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
     //       instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)     //TODO: necessary to center?
        ])
    }
}

extension DetailViewController: DetailViewModelDelegate {

    func prepareDetailUI(with recipe: [RecipeModel]) {
        print(recipe)
    }

    func didCatchError(error: Error) {
        print(error)
    }


}
