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

        let label2 = UILabel()
        label2.text = "Ingredients"
        label2.font = .boldSystemFont(ofSize: 19)
        label2.backgroundColor = .yellow
        label2.numberOfLines = 0
        stackView.addArrangedSubview(label2)
    }

    private func addStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20

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
        let label = UILabel()
        label.text = "Chocolate Cake"
        label.font = .boldSystemFont(ofSize: 24)
        label.backgroundColor = .magenta
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }

    private func addImageView() {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        stackView.addArrangedSubview(imageView)
    }

}
