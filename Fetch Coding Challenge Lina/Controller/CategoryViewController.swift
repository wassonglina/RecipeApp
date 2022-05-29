//
//  CategoryViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Foundation
import UIKit


class CategoryViewController: UIViewController {

    private var dataSource: UITableViewDiffableDataSource<Int, CategoryItemModel>!

    let categoryViewModel = CategoryViewModel()   //TODO: outside of viewDidLoad?
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryViewModel.delegate = self
        categoryViewModel.getCategoryData()

        //TODO: leave here?
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        self.title = "Dessert"

        dataSource = UITableViewDiffableDataSource<Int, CategoryItemModel>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as! RecipeTableViewCell
            //if it's getting more complex make view model for cell to pass on information
            cell.setTitle(with: item.name.capitalized)
            cell.setImage(with: item.image)

            return cell
        }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath =  tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

//MARK: - Extension UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
            let detailViewModel = DetailViewModel(id: selectedItem.id)
            let detailViewController = DetailViewController(detailViewModel: detailViewModel)  //look up
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

//MARK: - Extension ViewModelDelegate

extension CategoryViewController: CategoryViewModelDelegate {

    func prepareCategoryUI(with category: [CategoryItemModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryItemModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(category)
        dataSource.apply(snapshot, animatingDifferences: false)
        //update here to hide potential loading state e.g. with enum
    }

    func didCatchError(error: Error) {
        print("Error")
    }
}
