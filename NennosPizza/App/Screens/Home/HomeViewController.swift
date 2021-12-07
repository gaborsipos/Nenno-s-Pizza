//
//  HomeViewController.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class HomeViewController: RootViewController {
    // MARK: - HomeViewControllerProtocol properties

    var viewModel: HomeViewModel {
        rootViewModel as! HomeViewModel
    }

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    // MARK: - RootViewController functions

    override func createView() -> NPView {
        let view = super.createView()

        view.addSubview(tableView)

        return view
    }

    override func initializeView() {
        super.initializeView()

        let cartItem = UIBarButtonItem(image: UIImage(named: "CartNavbar")?.withRenderingMode(.alwaysOriginal),
                                       style: .plain,
                                       target: self,
                                       action: #selector(handleCartTapped))
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddTapped))
        navigationItem.leftBarButtonItem = cartItem
        navigationItem.rightBarButtonItem = addItem

        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")

        viewModel.pizzas
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: HomeTableViewCell.self)) { [weak self] _, pizza, cell in
                guard let self = self else { return }

                if let imageUrl = pizza.imageUrl {
                    cell.pizzaImageView.setupImage(imageUrl)
                }
                cell.nameLabel.text = pizza.name
                cell.ingredientsLabel.text = pizza.addedIngredients.map({ $0.name }).joined(separator: ", ")

                let formattedPrice = amountFormatter.string(from: NSNumber(value: pizza.price)) ?? String(pizza.price)
                cell.cartButton.setTitle(formattedPrice, for: .normal)
                cell.cartButton.rx.tap
                    .bind {
                        self.viewModel.addPizzaToCart(pizza)
                    }
                    .disposed(by: self.disposeBag)
                cell.tap = {
                    self.openPizzaCreator(pizza: pizza)
                }
            }
            .disposed(by: disposeBag)
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Functions

    @objc
    private func handleCartTapped() {
        openCart()
    }

    @objc
    private func handleAddTapped() {
        openPizzaCreator()
    }
}

// MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {
}

// MARK: - Router

extension HomeViewController: Router {
}
