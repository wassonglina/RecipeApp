//
//  CategoryViewController.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import Foundation
import UIKit


class CategoryViewController: UIViewController {

    private var dataSource: UITableViewDiffableDataSource<Int, CategoryModel>!

    let categoryViewModel = CategoryViewModel()   //TODO: outside of viewDidLoad?

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryViewModel.delegate = self
        categoryViewModel.getCategoryData()

        //TODO: leave here?
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        
        dataSource = UITableViewDiffableDataSource<Int, CategoryModel>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as! RecipeTableViewCell
            cell.setTitle(with: item.name)
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

    func prepareCategoryUI(with category: [CategoryModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(category)
        dataSource.apply(snapshot)
    }

    func didCatchError(error: Error) {
        print("Error")
    }
}
