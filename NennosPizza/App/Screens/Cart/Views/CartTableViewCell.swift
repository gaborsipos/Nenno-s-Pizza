//
//  CartTableViewCell.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

class CartTableViewCell: NPTableViewCell {
    // MARK: - Properties

    var tap: (() -> Void)?

    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.tintColor = UIColor(hex: "#E14D45")

        return iconImageView
    }()

    private lazy var titleLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        nameLabel.textColor = UIColor(hex: "#4A4A4A")
        nameLabel.numberOfLines = 0

        return nameLabel
    }()

    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 17)
        priceLabel.textColor = UIColor(hex: "#4A4A4A")
        priceLabel.numberOfLines = 1

        return priceLabel
    }()

    // MARK: - NPTableViewCell functions

    override func createView() {
        super.createView()

        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }

    override func initializeView() {
        super.initializeView()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    override func setupConstraints() {
        super.setupConstraints()

        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(10)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }

        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(12).priority(200)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
    }

    // MARK: - Functions

    func setupView(with viewModel: CartCellModel) {
        tap = viewModel.tap

        if let systemName = viewModel.imageName {
            iconImageView.image = UIImage(systemName: systemName)
        } else {
            iconImageView.image = nil
        }

        titleLabel.text = viewModel.title

        priceLabel.text = amountFormatter.string(from: NSNumber(value: viewModel.price)) ?? String(viewModel.price)
    }

    @objc
    private func handleTap() {
        tap?()
    }
}
