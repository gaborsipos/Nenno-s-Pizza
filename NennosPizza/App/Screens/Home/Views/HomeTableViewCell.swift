//
//  HomeTableViewCell.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

class HomeTableViewCell: NPTableViewCell {
    // MARK: - Properties

    var tap: (() -> Void)?

    lazy var pizzaImageView: PizzaImageView = {
        let pizzaImageView = PizzaImageView()
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false

        return pizzaImageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.numberOfLines = 1

        return nameLabel
    }()

    lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.font = UIFont.systemFont(ofSize: 14)
        ingredientsLabel.numberOfLines = 3

        return ingredientsLabel
    }()

    lazy var cartButton: UIButton = {
        let cartButton = UIButton(type: .custom)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cartButton.tintColor = .white
        cartButton.setImage(UIImage(named: "Cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartButton.setBackgroundImage(UIImage(color: UIColor(hex: "#FFCD2B")), for: .normal)
        cartButton.layer.cornerRadius = 4
        cartButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)

        return cartButton
    }()

    private lazy var infoContainer: UIView = {
        let infoContainer = UIView()
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        infoContainer.backgroundColor = UIColor(hex: "#F8F8F8").withAlphaComponent(0.8)

        return infoContainer
    }()

    // MARK: - NPTableViewCell functions

    override func createView() {
        super.createView()

        contentView.addSubview(pizzaImageView)
        contentView.addSubview(infoContainer)
        infoContainer.addSubview(nameLabel)
        infoContainer.addSubview(ingredientsLabel)
        infoContainer.addSubview(cartButton)
    }

    override func initializeView() {
        super.initializeView()

        selectionStyle = .none

        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    override func setupConstraints() {
        super.setupConstraints()

        pizzaImageView.snp.makeConstraints { make in
            make.height.equalTo(UIView.scaledHeight(fromContentWidth: contentView.frame.size.width,
                                                    designedWidth: 375,
                                                    designedHeight: 175))
            make.edges.equalToSuperview()
        }

        infoContainer.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
        }

        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.equalTo(nameLabel)
            make.bottom.equalToSuperview().offset(-12)
        }

        cartButton.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(ingredientsLabel.snp.right).offset(67)
            make.left.equalTo(ingredientsLabel.snp.right).offset(67).priority(200)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    // MARK: - Functions

    @objc
    private func handleTap() {
        tap?()
    }
}
