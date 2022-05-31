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
    private let label = UILabel()
    private let thumbImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(thumbImageView)
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.layer.masksToBounds = true

        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0

        let padding = 15.0

        let heightConstraint = thumbImageView.heightAnchor.constraint(equalTo: thumbImageView.widthAnchor)
        heightConstraint.priority = .defaultHigh        //set to .defaultHigh priority otherwise conflicting constraints in cell

        NSLayoutConstraint.activate([
            thumbImageView.widthAnchor.constraint(equalToConstant: 90),
            heightConstraint,
            thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            thumbImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),

            label.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 25),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(with title: String) {
        label.text = title
    }

    func setImage(with stringURL: String) {
        let url = URL(string: stringURL)
        thumbImageView.kf.setImage(with: url)
    }
}


