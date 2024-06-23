//
//  Article.swift
//  NewsApp
//
//  Created by Tommy Han on 23/6/2024.
//

import Foundation

struct Source: Codable {
    let id: Int?
    let name: String
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
