//
//  ArticleListAPIClientProtocol.swift
//  QiitaClient
//
//  Created by nishihara on 2018/10/14.
//  Copyright © 2018年 paranishian. All rights reserved.
//

import Foundation

protocol ArticleListAPIClientProtocol {
    func fetch(completion: @escaping (([Article]?) -> Void))
}
