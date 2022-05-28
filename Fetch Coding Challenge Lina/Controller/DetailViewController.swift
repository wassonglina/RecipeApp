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
    private let ingredientLabel = UILabel()
    private let measurementLabel = UILabel()
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
        ingredientStackView.spacing = 25
        ingredientStackView.backgroundColor = .systemMint
        ingredientStackView.addArrangedSubview(measurementLabel)
        ingredientStackView.addArrangedSubview(ingredientLabel)
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

    func prepareDetailUI(with recipe: RecipeModel) {
        print(#function, recipe)

        DispatchQueue.main.async {
            self.titleLabel.text = recipe.name
            self.ingredientLabel.text = recipe.ingredients[0].0
            self.measurementLabel.text = recipe.ingredients[0].1
            self.instructionLabel.text = recipe.instruction

//            for i in 0..<recipe.ingredients.count {
//                print(i)
//                let ingredient = recipe.ingredients[i].0
//                let label = UILabel()
//                label.text = ingredient
//                self.ingredientStackView.addArrangedSubview(label)
//                print(ingredient)
//            }
        }



    }

    func didCatchError(error: Error) {
        print(#function, error)
    }
}



//override func viewDidLoad() {
//    super.viewDidLoad()
//    var yPos = 90
//    for i in 0..<dataArr.count {
//        let element = dataArr[i]
//        let labelNum = UILabel()
//        let split = element.components(separatedBy: ",")
//
//        let num1 = split[0]
//        let num2 = split[1]
//
//        let num1Nnum2 = "number 1 :" + num1 + " number 2:" + num2
//        labelNum.text = num1Nnum2
//        labelNum.textAlignment = .center
//        labelNum.frame = CGRect( x:10, y:yPos, width:250, height: 80)
//        yPos += 80
//        self.view.addSubview(labelNum)
//
//    }
