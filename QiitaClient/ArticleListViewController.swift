//
//  ArticleListViewController.swift
//  QiitaClient
//
//  Created by nishihara on 2018/10/14.
//  Copyright © 2018年 paranishian. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    let titleLabel = UILabel()
    let client: ArticleListAPIClientProtocol
    let tableView = UITableView()
    var items: [Article] = []
    
    init(client: ArticleListAPIClientProtocol = ArticleListAPIClient()) {
        self.client = client
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        titleLabel.leftAnchor
            .constraint(equalTo: view.leftAnchor, constant: 16)
            .isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.rightAnchor
            .constraint(equalTo: view.rightAnchor)
            .isActive = true
        tableView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        tableView.leftAnchor
            .constraint(equalTo: view.leftAnchor)
            .isActive = true
        tableView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
        tableView.dataSource = self
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: "ArticleListCell")
        
        client.fetch { [weak self] (articleList) in
            guard
                let articleList = articleList,
                0 < articleList.count else { return }
            
            self?.items = articleList
            self?.tableView.reloadData()
        }
    }
}

extension ArticleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListCell") as! ArticleListCell
        
        let article = items[indexPath.row]
        cell.titleLabel.text = article.title
        
        return cell
    }
}
