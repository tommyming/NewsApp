//
//  EmptyListView.swift
//  NewsApp
//
//  Created by Tommy Han on 23/6/2024.
//

import Foundation
import UIKit

class EmptyListView: UIView {
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Results"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
