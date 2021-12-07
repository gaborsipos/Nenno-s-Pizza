//
//  CheckoutSuccessViewController.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import SnapKit
import UIKit

final class CheckoutSuccessViewController: RootViewController {
    // MARK: - CheckoutSuccessViewControllerProtocol properties

    var viewModel: CheckoutSuccessViewModel {
        rootViewModel as! CheckoutSuccessViewModel
    }

    // MARK: - Properties

    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.italicSystemFont(ofSize: 34)
        messageLabel.textColor = UIColor(hex: "#DF4E4A")
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        return messageLabel
    }()

    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setBackgroundImage(UIImage(color: UIColor(hex: "#E14D45")), for: .normal)
        backButton.tintColor = .white
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return backButton
    }()

    // MARK: - RootViewController functions

    override func createView() -> NPView {
        let view = super.createView()

        view.addSubview(messageLabel)
        view.addSubview(backButton)

        return view
    }

    override func initializeView() {
        super.initializeView()

        messageLabel.text = "Thank you for your order!"
        backButton.setTitle("BACK", for: .normal)

        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.popToRoot()
            })
            .disposed(by: disposeBag)
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
        }

        backButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - CheckoutSuccessViewControllerProtocol

extension CheckoutSuccessViewController: CheckoutSuccessViewControllerProtocol {
}

// MARK: - Router

extension CheckoutSuccessViewController: Router {
}
