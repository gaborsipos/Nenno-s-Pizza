//
//  NPView.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

class NPView: UIView {
    // MARK: - UIView properties

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    // MARK: - NPViewProtocol properties

    var view: NPView {
        return self
    }

    // MARK: - Properties

    var shouldUpdateConstrains = true {
        didSet {
            if shouldUpdateConstrains {
                setNeedsUpdateConstraints()
            }
        }
    }

    private(set) var didSetupConstraints: Bool = false

    // MARK: - UIView initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        createView()
        initializeView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView functions

    override func updateConstraints() {
        if shouldUpdateConstrains {
            shouldUpdateConstrains = false
            setupConstraints()

            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    // MARK: - Functions

    /// Override this function to add subviews.
    func createView() {
    }

    /// Override this function to add custom initialization to your views. Will be called after the `createView()`.
    func initializeView() {
        accessibilityIdentifier = String(describing: type(of: self))
    }

    /// Override this function to add auto layout constraints. Set `shouldUpdateConstraints` to `true` to trigger this.
    func setupConstraints() {
    }
}

// MARK: - NPViewProtocol

extension NPView: NPViewProtocol {
}
