//
//  DrinksViewController.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class DrinksViewController: RootViewController {
    // MARK: - DrinksViewControllerProtocol properties

    var viewModel: DrinksViewModel {
        rootViewModel as! DrinksViewModel
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

        title = "DRINKS"

        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cell")

        viewModel.drinkCells
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: CartTableViewCell.self)) { _, viewModel, cell in
                cell.setupView(with: viewModel)
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
}

// MARK: - DrinksViewControllerProtocol

extension DrinksViewController: DrinksViewControllerProtocol {
}
