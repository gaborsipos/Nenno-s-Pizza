//
//  NPSnackbarView.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

class NPSnackbarView: NPView {
    // MARK: - Properties

    var message: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }

    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center

        return messageLabel
    }()

    // MARK: - NPView functions

    override func createView() {
        super.createView()

        addSubview(messageLabel)
    }

    override func initializeView() {
        super.initializeView()

        backgroundColor = UIColor(hex: "#E14D45").withAlphaComponent(0.8)
    }

    override func setupConstraints() {
        super.setupConstraints()

        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}
