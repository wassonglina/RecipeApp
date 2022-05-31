//
//  DetailViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/26/22.
//


import UIKit
import Kingfisher


class DetailViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    let detailViewModel: DetailViewModel

    private let instructionLabel = UILabel()
    private let titleLabel = UILabel()
    private let ingredientStackView = UIStackView()
    private let imageView = UIImageView()
    private let ingredientsLabel = UILabel()

    private let customSpacing = 40.0
    private let customSpacingLabel = 15.0

    init(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)       //look up
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        detailViewModel.delegate = self
        detailViewModel.getRecipe()  //has no idea about id
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label         //no need to make one?

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
        stackView.spacing = customSpacing

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
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
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }

    private func addTitleLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
    }

    private func addImageView() {
        imageView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        stackView.addArrangedSubview(imageView)
    }

    private func addIngredientsTitleLabel() {
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = .boldSystemFont(ofSize: 19)
        stackView.addArrangedSubview(ingredientsLabel)
        stackView.setCustomSpacing(customSpacingLabel, after: ingredientsLabel)
    }

    private func addIngredientStackView() {
        stackView.addArrangedSubview(ingredientStackView)
        ingredientStackView.spacing = 15
        ingredientStackView.axis = .vertical
        stackView.setCustomSpacing(customSpacing, after: ingredientStackView)
    }

    private func addInstructionTitleLabel() {
        let instructionLabel = UILabel()
        instructionLabel.text = "Instructions"
        instructionLabel.font = .boldSystemFont(ofSize: 19)
        stackView.addArrangedSubview(instructionLabel)
        stackView.setCustomSpacing(customSpacingLabel, after: instructionLabel)
    }

    private func addInstructionsLabel() {
        instructionLabel.numberOfLines = 0
        stackView.addArrangedSubview(instructionLabel)
        instructionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -70).isActive = true  //TODO: check for landscape
    }
}

//MARK: - Extension DetailViewModelDelegate

extension DetailViewController: DetailViewModelDelegate {

    func prepareDetailUI(name: String, image: String, ingredients: [IngredientInfo], instruction: String) {

        titleLabel.text = name
        let url = URL(string: image)
        imageView.kf.setImage(with: url)
        instructionLabel.text = instruction
        ingredients.forEach {
            let ingredientLabel = UILabel()
            ingredientLabel.text = "\($0.measurement) \($0.ingredient)"
            self.ingredientStackView.addArrangedSubview(ingredientLabel)

            //update here to hide potential loading state e.g. with enum
        }
    }

    func didCatchError(error: Error) {
        print(#function, error)
    }
}


