//
//  ItemsView.swift
//  MVC-Realm
//
//  Created by Zafar on 2/1/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class ItemsView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let vc = controller as! ItemsViewController
        vc.navigationItem.rightBarButtonItem = addBarItem
        
        controller?.onViewLayout()
    }
    
    // MARK: - Actions
    @objc func addTapped() {
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            if let title = alert.textFields?.first!.text, !title.isEmpty {
                self.controller?.onSaveTap(title: title)
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Item's title"
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        controller?.onAddTap(alert: alert)
    }
    
    // MARK: - Properties
    weak var controller: ItemsViewInput?
    private var titles = [String]()
    
    lazy var addBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        item.tintColor = .systemYellow
        return item
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView
            .translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .darkGray
        label.text = "No stored items yet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - Controller Output
extension ItemsView: ItemsControllerOutput {
    
    func onItemsRetrieval(titles: [String]) {
        print("View receives a result from Controller and updates itself")
        self.titles = titles
        self.tableView.reloadData()
    }
    
    func onItemAddition(title: String) {
        print("View receives a result from Controller and updates itself")
        self.titles.append(title)
        self.tableView.reloadData()
    }
    
    func onItemDeletion(index: Int) {
        print("View receives a result from Controller and updates itself")
        self.titles.remove(at: index)
        self.tableView.reloadData()
    }
    
    
}

// MARK: - UITableView Delegate & DataSource
extension ItemsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = self.titles.isEmpty
        placeholderLabel.isHidden = !self.titles.isEmpty

        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.onCellSelection(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller?.onDeleteSelection(index: indexPath.row)
        }
    }
}

// MARK: - UI Setup
extension ItemsView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor = .white

        self.addSubview(tableView)
        self.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            tableView.widthAnchor
                .constraint(equalTo: self.widthAnchor),
            tableView.heightAnchor
                .constraint(equalTo: self.heightAnchor),
            placeholderLabel.centerXAnchor
                .constraint(equalTo: self.centerXAnchor),
            placeholderLabel.centerYAnchor
                .constraint(equalTo: self.centerYAnchor)
        ])
    }
}
