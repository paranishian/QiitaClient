//
//  ArticleListViewControllerTests.swift
//  QiitaClientTests
//
//  Created by nishihara on 2018/10/14.
//  Copyright © 2018年 paranishian. All rights reserved.
//

import XCTest
@testable import QiitaClient

class ArticleListViewControllerTests: XCTestCase {
    
    func test_タイトルの一覧が表示されること() {
        let article = Article(title: "記事タイトル")
        let client = FakeArticleListAPIClient(fakeResponse: [article])
        let vc = ArticleListViewController(client: client)
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
        
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

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
