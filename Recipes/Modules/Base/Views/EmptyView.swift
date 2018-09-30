//
//  EmptyView.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

/// Used to show when there's no data
final class EmptyView: UIView {
    private lazy var imageView: UIImageView = self.makeImageView()
    private lazy var label: UILabel = self.makeLabel()
    
    required init(text: String) {
        super.init(frame: .zero)
        
        isUserInteractionEnabled = false
        addSubviews([imageView, label])
        label.text = text
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(imageView.snp.width)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Make
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.notFound()
        return imageView
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
}

