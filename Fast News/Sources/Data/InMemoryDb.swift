//
//  InMemoryDb.swift
//  Fast News
//
//  Created by Rafael Adolfo on 05/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

final class InMemoryDb {
    //MARK: - Properties
    var hotNews: [HotNews]
    
    //MARK: - singleton
    static let shared = InMemoryDb()
    
    init() {
        hotNews = []
    }
}

extension InMemoryDb {
    
    func save(model: HotNews) {
        hotNews.append(model)
    }
    
    func removeAll(){
        hotNews.removeAll()
    }
    
    func getHotNews() -> [HotNews] {
        return hotNews
    }
}
