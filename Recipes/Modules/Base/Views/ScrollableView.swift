//
//  ScrollableView.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

/// Vertically layout view using Auto Layout in UIScrollView
final class ScrollableView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    struct Pair {
        let view: UIView
        let inset: UIEdgeInsets
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setup(pairs: [Pair]) {
        pairs.enumerated().forEach({ tuple in
            let view = tuple.element.view
            let inset = tuple.element.inset
            let offset = tuple.offset
            
            scrollView.addSubview(view)
            
            view.snp.makeConstraints {
                $0.trailing.equalTo(contentView).offset(-inset.right)
                $0.leading.equalTo(contentView).offset(inset.left)
                
                if offset == 0 {
                    $0.top.equalTo(contentView).offset(inset.top)
                } else {
                    $0.top.equalTo(pairs[offset - 1].view.snp.bottom).offset(inset.top)
                }
                
                if offset == pairs.count - 1 {
                    $0.bottom.equalTo(contentView).offset(-inset.bottom)
                }
            }
        })
    }
}
