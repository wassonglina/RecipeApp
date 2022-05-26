//
//  CategoryViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Foundation
import UIKit


class CategoryViewController: UIViewController {

    private var dataSource: UITableViewDiffableDataSource<Int, RecipeModel>!

    let categoryViewModel = CategoryViewModel()   //TODO: outside of viewDidLoad?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan

        //TODO: move to ViewModel
        categoryViewModel.getCategoryData()

        //TODO: leave here?
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .magenta
        tableView.translatesAutoresizingMaskIntoConstraints = false
        dataSource = UITableViewDiffableDataSource<Int, RecipeModel>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as! RecipeTableViewCell
            cell.setTitle(item.dessertName)
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
}

//MARK: - Extension UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {

    //TODO: when cell is tapped get ingredients with addtl. network request with mealID > move to Detail VC and populate UI
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}


    //TODO:  to View Model?
//    func didFetchCategory(_ recipes: [RecipeModel]) {
//        var snapshot = NSDiffableDataSourceSnapshot<Int, RecipeModel>()
//        snapshot.appendSections([0])
//        snapshot.appendItems(recipes)
//        dataSource.apply(snapshot)
//    }

//    func didCatchError(error: Error) {
//        //handle Errors here
//        print("Error")
//    }


//MARK: - Extension ViewModelDelegate

extension CategoryViewController: ViewModelDelegate {

    func prepareCategoryUI(_ category: [RecipeModel]) {
        print(#function, category)
    }

    func didCatchError(error: Error) {
        //handle Errors here
        print("Error")
    }

    //TODO:  to View Model?

}
