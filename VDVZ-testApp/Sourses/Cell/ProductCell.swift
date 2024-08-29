//
//  ProducCell.swift
//  VDVZ-testApp
//
//  Created by Ivan Rybkin on 27.08.2024.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let identifier = "ProductCell"

    let padding: CGFloat = 4

    let ruble = " ₽"

    // MARK: - Outlets

    private var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let price: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(resource: .basket)
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(resource: .heart)
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupHierarchy()
        setupLayout()
        setupBorder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        contentView.addSubviews(productImage, likeButton, price, addButton)
    }

    private func setupLayout() {

        productImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-70)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
            make.leading.equalTo(contentView.snp.leading).offset(30)
        }

        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(24)
        }

        price.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
        }

        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
}

    private func setupBorder() {
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        contentView.layer.borderWidth = 0.2
    }

    // MARK: - LoadImage

    func configuration(model: ProductData) {
        guard let imagePath = model.detailPicture,
              let imageURL = URL(string: "https://szorin.vodovoz.ru" + imagePath)
        else {
            self.productImage.image = UIImage(systemName: "camera.fill")
            return
        }
        loadImage(from: imageURL)
        self.price.text = (model.extendedPrice.first?.price.description ?? "") + ruble
        print("\(String(describing: model.extendedPrice.first?.price.description))")
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if error == nil, let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(systemName: "camera.fill")
                }
            }
        }.resume()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImage.image = nil
    }
}
