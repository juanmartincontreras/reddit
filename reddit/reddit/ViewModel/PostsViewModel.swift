//
//  PostsViewModel.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import Foundation

class PostsViewModel {

    private let postsService = PostsService()

    var posts: [Post]?

    var onPostsLoaded: (() -> Void)?

    var onError: ((_ error: Error) -> Void)?

    func loadTopPosts() {
        postsService.getTopPosts { response in
            self.posts = response.data.children?.map({ postItem -> Post in
                postItem.data
            })
            self.onPostsLoaded?()
        } onError: { error in
            self.onError?(error)
        }
    }

}
