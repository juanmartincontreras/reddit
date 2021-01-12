//
//  PostsService.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import Foundation

class PostsService {

    func getTopPosts(onSuccess: @escaping( _ response: PostsResponse) -> Void, onError: @escaping( _ error: Error) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: API.topPosts) else {
            return
        }
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            let decoder = JSONDecoder()
            if let errorResponse = error {
                onError(errorResponse)
            } else if let responseData = data {
                do {
                    let response = try decoder.decode(PostsResponse.self, from: responseData)
                    onSuccess(response)
                } catch {
                    onError(error)
                }
            }
        })
        task.resume()
    }

}
