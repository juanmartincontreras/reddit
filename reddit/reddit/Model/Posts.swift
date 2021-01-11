//
//  PostsResponse.swift
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

struct Post: Codable {
    let selftext: String
    let clicked: Bool
    let title, thumbnail, selftextHTML: String
    let visited: Bool
    let id, author: String
    let numComments: Int
    let url: String
    let createdUTC: Int

    enum CodingKeys: String, CodingKey {
        case selftext, clicked, title, thumbnail
        case selftextHTML = "selftext_html"
        case visited, id, author
        case numComments = "num_comments"
        case url
        case createdUTC = "created_utc"
    }
}
