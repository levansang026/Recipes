//
//  RecipeListViewController.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit
import RxSwift

/// Show a list of recipes
final class RecipeListViewController: UIViewController {
    private(set) var collectionView: UICollectionView!
    private let emptyView = EmptyView(text: "No recipes found!")
    let adapter = Adapter<Recipe, RecipeCell>()
    
    private let disposeBag = DisposeBag()
    var viewModel: RecipeListViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        collectionView.register(cellType: RecipeCell.self)
        collectionView.backgroundColor = Color.background
        collectionView.contentInset.top = 8
        collectionView.alwaysBounceVertical = true
        
        adapter.configure = { recipe, cell in
            cell.imageView.setImage(url: URL(string: recipe.imageUrl)!, placeholder: R.image.recipePlaceholder())
            cell.label.text = recipe.title
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { $0.edges.equalToSuperview() }
        emptyView.alpha = 0
    }
    
    func setupBindings() {
        viewModel.recipesVariable.asObservable().subscribe(onNext: { [weak self] recipes in
            
            self?.adapter.items = recipes
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                UIView.animate(withDuration: 0.25, animations: {
                    self?.emptyView.alpha = recipes.isEmpty ? 1 : 0
                })
            }
            
        }).disposed(by: disposeBag)
    }
    
    func handle(recipes: [Recipe]) {
        adapter.items = recipes
        self.collectionView.reloadData()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.emptyView.alpha = recipes.isEmpty ? 1 : 0
        })
    }
}

