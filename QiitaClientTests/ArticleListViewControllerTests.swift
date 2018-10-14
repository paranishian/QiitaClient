//
//  ArticleListViewControllerTests.swift
//  QiitaClientTests
//
//  Created by nishihara on 2018/10/14.
//  Copyright © 2018年 paranishian. All rights reserved.
//

import XCTest
import SafariServices
@testable import QiitaClient

class ArticleListViewControllerTests: XCTestCase {
    
    var vc: ArticleListViewController!
    
    override func setUp() {
        let article = Article(title: "記事タイトル", url: "http://test")
        let client = FakeArticleListAPIClient(fakeResponse: [article])
        vc = ArticleListViewController(client: client)
    }
    
    func test_タイトルの一覧が表示されること() {
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        guard
            let cell = vc.tableView.dataSource?
                .tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ArticleListCell
            else {
                XCTFail()
                return
        }
        
        XCTAssertEqual(cell.titleLabel.text, "記事タイトル")
    }
    
    func test_記事をタップして詳細画面が表示されること() {
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        vc.tableView(vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(vc.presentedViewController is SFSafariViewController)
    }
        
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

class FakeArticleListAPIClient: ArticleListAPIClientProtocol {
    let fakeResponse: [Article]
    
    init(fakeResponse: [Article]) {
        self.fakeResponse = fakeResponse
    }
    
    func fetch(completion: @escaping (([Article]?) -> Void)) {
        completion(fakeResponse)
    }
}
