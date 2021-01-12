//
//  PostsViewModel.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import Foundation

class PostsViewModel {

    private let postsService = PostsService()

    var onPostsLoaded: ((_ posts: [Post]?) -> ())?
    var onError: ((_ error: Error) -> ())?

    func loadTopPosts() {
        postsService.getTopPosts { response in
            let posts = response.data.children?.map({ postItem -> Post in
                postItem.data
            })
            self.onPostsLoaded?(posts)
        } onError: { error in
            self.onError?(error)
        }
    }

}
