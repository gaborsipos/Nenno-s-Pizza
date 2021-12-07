//
//  NPTableViewCell.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

class NPTableViewCell: UITableViewCell {
    // MARK: - Properties

    var shouldUpdateConstrains: Bool = true {
        didSet {
            if shouldUpdateConstrains {
                setNeedsUpdateConstraints()
            }
        }
    }

    // MARK: - UITableViewCell initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createView()
        initializeView()

        setNeedsUpdateConstraints()
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView functions

    override func updateConstraints() {
        if shouldUpdateConstrains {
            shouldUpdateConstrains = false
            setupConstraints()
        }
        super.updateConstraints()
    }

    // MARK: - Functions

    func createView() {
    }

    func initializeView() {
    }

    func setupConstraints() {
    }
}
