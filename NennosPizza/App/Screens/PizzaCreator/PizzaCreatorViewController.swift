//
//  PizzaCreatorViewController.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class PizzaCreatorViewController: RootViewController {
    // MARK: - PizzaCreatorViewControllerProtocol properties

    var viewModel: PizzaCreatorViewModel {
        rootViewModel as! PizzaCreatorViewModel
    }

    // MARK: - Properties

    private lazy var pizzaImageView: PizzaImageView = {
        let pizzaImageView = PizzaImageView()
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false

        return pizzaImageView
    }()

    private lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        ingredientsLabel.numberOfLines = 1

        return ingredientsLabel
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var addToCartButton: UIButton = {
        let addToCartButton = UIButton(type: .custom)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.setBackgroundImage(UIImage(color: UIColor(hex: "#FFCD2B")), for: .normal)
        addToCartButton.setBackgroundImage(UIImage(color: UIColor(hex: "#FFCD2B").withAlphaComponent(0.5)), for: .disabled)
        addToCartButton.tintColor = .white
        addToCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return addToCartButton
    }()

    // MARK: - RootViewController functions

    override func createView() -> NPView {
        let view = super.createView()

        view.addSubview(ingredientsLabel)
        view.addSubview(tableView)
        view.addSubview(addToCartButton)

        return view
    }

    override func initializeView() {
        super.initializeView()

        viewModel.pizzaPublisher
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] pizza in
                guard let self = self else { return }

                self.title = pizza.name.uppercased()

                if let imageUrl = pizza.imageUrl {
                    self.view.addSubview(self.pizzaImageView)
                    self.pizzaImageView.setupImage(imageUrl)
                }
            })
            .disposed(by: disposeBag)

        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cell")

        ingredientsLabel.text = "Ingredients"

        viewModel.ingredientCells
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: CartTableViewCell.self)) { _, viewModel, cell in
                cell.setupView(with: viewModel)
            }
            .disposed(by: disposeBag)

        viewModel.totalPrice
            .observe(on: MainScheduler.instance)
            .bind(to: addToCartButton.rx.title())
            .disposed(by: disposeBag)

        viewModel.addToCartButtonEnabled
            .observe(on: MainScheduler.instance)
            .bind(to: addToCartButton.rx.isEnabled)
            .disposed(by: disposeBag)

        addToCartButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.addPizzaToCart()
            })
            .disposed(by: disposeBag)
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        if pizzaImageView.superview != nil {
            pizzaImageView.snp.makeConstraints { make in
                make.height.equalTo(UIView.scaledHeight(fromContentWidth: view.frame.size.width,
                                                        designedWidth: 375,
                                                        designedHeight: 300))
                make.top.equalTo(view.safeAreaInsets)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(ingredientsLabel.snp.top).offset(-12)
            }
        }

        ingredientsLabel.snp.makeConstraints { make in
            if pizzaImageView.superview == nil {
                make.top.equalTo(view.safeAreaInsets)
            }
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
        }

        addToCartButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(tableView.snp.bottom).priority(200)
            make.top.greaterThanOrEqualTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - PizzaCreatorViewControllerProtocol

extension PizzaCreatorViewController: PizzaCreatorViewControllerProtocol {
}
