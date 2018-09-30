//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import SnapKit

final class RecipeDetailView: UIView {
    private let scrollableView = ScrollableView()
    private(set) lazy var imageView: UIImageView = self.makeImageView()
    private(set) lazy var ingredientLabel: UILabel = self.makeIngredientLabel()
    private(set) lazy var instructionButton: UIButton = self.makeButton()
    private(set) lazy var originalButton: UIButton = self.makeButton()
    private(set) lazy var infoView: InfoView = InfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        let ingredientHeaderView = HeaderView(text: "Ingredients")
        let infoHeaderView = HeaderView(text: "Info")
        instructionButton.setTitle("View instructions", for: .normal)
        originalButton.setTitle("View original", for: .normal)
        
        addSubview(scrollableView)
        scrollableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollableView.setup(pairs: [
            ScrollableView.Pair(view: imageView, inset: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)),
            ScrollableView.Pair(view: ingredientHeaderView, inset: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)),
            ScrollableView.Pair(view: ingredientLabel, inset: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 0)),
            ScrollableView.Pair(view: infoHeaderView, inset: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)),
            ScrollableView.Pair(view: instructionButton, inset: UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20)),
            ScrollableView.Pair(view: originalButton, inset: UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20)),
            ScrollableView.Pair(view: infoView, inset: UIEdgeInsets(top: 16, left: 0, bottom: 20, right: 0))
            ])
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width).multipliedBy(9.0/16)
        }
        
        ingredientHeaderView.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        infoHeaderView.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        instructionButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        originalButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Make
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func makeIngredientLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = Color.main
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitleColor(.darkGray, for: .highlighted)
        return button
    }
}

private final class HeaderView: UIView {
    private(set) lazy var label: UILabel = self.makeLabel()
    
    required init(text: String) {
        super.init(frame: .zero)
        label.text = text
        addSubview(label)
        backgroundColor = Color.main.withAlphaComponent(0.8)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        round(corners: .topRight)
    }
    
    // MARK: - Make
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
    }
}

final class InfoView: UIView {
    private(set) lazy var leftLabel: UILabel = self.makeLabel()
    private(set) lazy var rightLabel: UILabel = self.makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews([leftLabel, rightLabel])
        rightLabel.textAlignment = .right
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Make
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }
    
    private func setupConstraints() {
        leftLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
}
