//
//  PizzaImageView.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import AlamofireImage
import UIKit

class PizzaImageView: NPView {
    // MARK: - Properties

    private lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "Wood"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill

        return backgroundImageView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    // MARK: - NPView functions

    override func createView() {
        super.createView()

        addSubview(backgroundImageView)
        backgroundImageView.addSubview(imageView)
    }

    override func initializeView() {
        super.initializeView()

        backgroundImageView.clipsToBounds = true
        imageView.clipsToBounds = true
    }

    override func setupConstraints() {
        super.setupConstraints()

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
    }

    // MARK: - Functions

    func setupImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }

        imageView.af.setImage(withURL: url)
    }
}
