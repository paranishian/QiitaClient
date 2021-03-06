//
//  ArticleListAPIClient.swift
//  QiitaClient
//
//  Created by nishihara on 2018/10/14.
//  Copyright © 2018年 paranishian. All rights reserved.
//

import Foundation

class ArticleListAPIClient: ArticleListAPIClientProtocol {
    
    func fetch(completion: @escaping (([Article]?) -> Void)) {
        guard let url = URL(string: "https://qiita.com/api/v2/items") else {
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let articleList = try? JSONDecoder().decode([Article].self, from: data)
            DispatchQueue.main.async {
                completion(articleList)
            }
        }.resume()
    }
}
