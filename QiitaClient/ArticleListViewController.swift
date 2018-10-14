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
        
        client.fetch { [weak self] (articleList) in
            guard
                let articleList = articleList,
                0 < articleList.count else { return }
            
            self?.titleLabel.text = articleList[0].title
        }
    }
}
