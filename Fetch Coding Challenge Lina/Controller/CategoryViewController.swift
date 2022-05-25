//
//  CategoryViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Foundation
import UIKit


class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan

        var recipeManager = RecipeManager()
        recipeManager.delegate = self

        recipeManager.performNetworkRequest(with: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")

        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .magenta
        tableView.translatesAutoresizingMaskIntoConstraints = false
        dataSource = UITableViewDiffableDataSource<Int, RecipeModel>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as! RecipeTableViewCell
            return cell
        }
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])


    }

    private var dataSource: UITableViewDiffableDataSource<Int, RecipeModel>!
}

//MARK: - Extension UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - Extension UITableViewDelegate

extension CategoryViewController: RecipeManagerDelegate {

    func didFetchRecipes(recipes: RecipeModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RecipeModel>()

        snapshot.appendSections([0])
        snapshot.appendItems([recipes])
        dataSource.apply(snapshot)
        print(#function, recipes)
    }

    func didCatchError(error: Error) {
        //handle Errors here
        print("Error")
    }

}
