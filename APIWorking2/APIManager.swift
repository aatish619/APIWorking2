//
//  APIManager.swift
//  APIWorking2
//
//  Created by Aatish Mehta on 12/22/23.
//

import Foundation

class APIManager {
    static let shared = APIManager() // Singleton instance
    private init() {}

    private let baseURL = "https://jsonplaceholder.typicode.com/posts"

    func postData(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(post)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Post.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func getData(completion: @escaping (Result<[Post], Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: baseURL)!) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
