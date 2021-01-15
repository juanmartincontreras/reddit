//
//  PostsResponse.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import Foundation

struct Post: Codable {
    let selftext: String
    let clicked: Bool
    let title: String
    let thumbnail: String
    let selftextHTML: String
    let visited: Bool
    let id: String
    let author: String
    let numComments: Int
    let url: String
    let createdUTC: Double

    enum CodingKeys: String, CodingKey {
        case selftext
        case clicked
        case title
        case thumbnail
        case selftextHTML = "selftext_html"
        case visited
        case id
        case author
        case numComments = "num_comments"
        case url
        case createdUTC = "created_utc"
    }
}
