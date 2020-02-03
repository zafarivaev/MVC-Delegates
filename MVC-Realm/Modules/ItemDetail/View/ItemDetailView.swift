//
//  ItemDetailView.swift
//  MVC-Realm
//
//  Created by Zafar on 2/2/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class ItemDetailView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        controller?.onViewLayout()
    }
    
    // MARK: - Properties
    
    weak var controller: ItemDetailViewInput?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: Controller Output
extension ItemDetailView: ItemDetailControllerOutput {
    
    func onItemRetrieval(title: String) {
        print("View receives a result from Controller and updates itself")
        titleLabel.text = title
    }
    
}

// MARK: - UI Setup
extension ItemDetailView {
    private func setupUI() {
        self.overrideUserInterfaceStyle = .light
        self.backgroundColor = .white
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
