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
    private let detailViewModel: DetailViewModel
    private let instructionLabel = UILabel()
    private let titleLabel = UILabel()
    private let ingredientStackView = UIStackView()
    private let imageView = UIImageView()
    private let ingredientsLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()

    private var top = NSLayoutConstraint()
    private var bottom =  NSLayoutConstraint()

    private let customSpacing = 40.0
    private let customSpacingLabel = 15.0

    //TODO: why not call override init- super.init??  >> not overriding it making new initializer and then overriding it
    init(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        detailViewModel.delegate = self
        detailViewModel.getRecipe()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label

        addScrollView()
        addStackView()
        addTitleLabel()
        addImageView()
        addIngredientsTitleLabel()
        addIngredientStackView()
        addInstructionTitleLabel()
        addInstructionsLabel()

        stackView.isHidden = true
    }

    //call with LoadingState enum case loading
    // create and start in one function or start seperate?
    private func startActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),  //scrollview content width constraint to frame width
        ])
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
        instructionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -70).isActive = true
    }
}

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
        }
        //update here to hide potential loading state e.g. with enum

        stackView.isHidden = false
        activityIndicator.stopAnimating()
    }

    func didCatchError(message: String) {

        activityIndicator.stopAnimating()
        
        let ac = UIAlertController(title: message, message: "Please try again later.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }

    func setState(state: LoadingState?) {

        switch state {
        case .loading:
            startActivityIndicator()
        case .loaded(let name, let image, let ingredients, let instruction):
            prepareDetailUI(name: name, image: image, ingredients: ingredients, instruction: instruction)
        case .failed(let error):
            didCatchError(message: error)
        case nil:       //case nil instead default: aknowledge new case
            didCatchError(message: "Something went totally wrong.")
        }
    }
}


