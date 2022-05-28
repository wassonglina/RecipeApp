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
    let detailViewModel: DetailViewModel

    private let instructionLabel = UILabel()
    private let titleLabel = UILabel()
    private let ingredientStackView = UIStackView()

    init(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)       //look up
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        detailViewModel.delegate = self

        detailViewModel.getRecipe()  //no idea about id

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
        stackView.addArrangedSubview(ingredientStackView)
        ingredientStackView.spacing = 15
        ingredientStackView.backgroundColor = .systemMint
        ingredientStackView.axis = .vertical
    }

    private func addInstructionTitleLabel() {
        let instructionLabel = UILabel()
        instructionLabel.text = "Instructions"
        instructionLabel.font = .boldSystemFont(ofSize: 19)
        instructionLabel.backgroundColor = .yellow
        stackView.addArrangedSubview(instructionLabel)
    }

    private func addInstructionsLabel() {
        instructionLabel.numberOfLines = 0
        stackView.addArrangedSubview(instructionLabel)
        instructionLabel.backgroundColor = .link
        instructionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -70).isActive = true  //TODO: check for landscape
    }
}



extension DetailViewController: DetailViewModelDelegate {


    func prepareDetailUI(name: String, instruction: String, ingredients: [(String, String)]) {

        DispatchQueue.main.async {
            self.titleLabel.text = name
            self.instructionLabel.text = instruction

            ingredients.forEach { (ing, mea) in
                let ingredientLabel = UILabel()
//                let attributedText = NSAttributedString(string: mea, attributes: [
//                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)
//                ])
//                ingredientLabel.attributedText = attributedText
                ingredientLabel.text = "\(mea) \(ing)"
                self.ingredientStackView.addArrangedSubview(ingredientLabel)
            }
        }
    }

    func didCatchError(error: Error) {
        print(#function, error)
    }
}


