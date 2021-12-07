//
//  CartViewController.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class CartViewController: RootViewController {
    // MARK: - CartViewControllerProtocol properties

    var viewModel: CartViewModel {
        rootViewModel as! CartViewModel
    }

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var submitButton: UIButton = {
        let submitButton = UIButton(type: .custom)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setBackgroundImage(UIImage(color: UIColor(hex: "#E14D45")), for: .normal)
        submitButton.tintColor = .white
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return submitButton
    }()

    // MARK: - RootViewController functions

    override func createView() -> NPView {
        let view = super.createView()

        view.addSubview(tableView)
        view.addSubview(submitButton)

        return view
    }

    override func initializeView() {
        super.initializeView()

        title = "CART"

        let drinksItem = UIBarButtonItem(image: UIImage(named: "Drinks")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(handleDrinksTapped))
        navigationItem.rightBarButtonItem = drinksItem

        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cell")

        viewModel.cartCells
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: CartTableViewCell.self)) { _, viewModel, cell in
                cell.setupView(with: viewModel)
            }
            .disposed(by: disposeBag)

        viewModel.totalPrice
            .observe(on: MainScheduler.instance)
            .bind(to: submitButton.rx.title())
            .disposed(by: disposeBag)

        viewModel.checkoutButtonEnabled
            .observe(on: MainScheduler.instance)
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        submitButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.checkout()
            })
            .disposed(by: disposeBag)

        viewModel.showCheckoutSuccess
            .subscribe(onNext: { [weak self] in
                self?.openCheckoutSuccess()
            })
            .disposed(by: disposeBag)
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        submitButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(tableView.snp.bottom).priority(200)
            make.top.greaterThanOrEqualTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Functions

    @objc
    private func handleDrinksTapped() {
        openDrinks()
    }
}

// MARK: - CartViewControllerProtocol

extension CartViewController: CartViewControllerProtocol {
}

// MARK: - Router

extension CartViewController: Router {
}
