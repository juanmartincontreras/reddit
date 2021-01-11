//
//  PostResponse.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import Foundation

struct PostsResponse: Codable {
    let data: PostsResponseData
}

struct PostsResponseData: Codable {
    let children: [Child]
    let after: String?
    let before: String?
}

struct Child: Codable {
    let kind: String
    let data: Post
}
