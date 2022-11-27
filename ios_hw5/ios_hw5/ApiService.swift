//
//  ApiService.swift
//  ios_hw5
//
//  Created by Zhasmin Mirzoeva on 27.11.2022.
//



import Foundation

class ApiService {
    static var shared = ApiService()
    var newsArray: [Article.Data] = []
    private let urlPath = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=17ba4457ddce45bdaab760f98f754661")
    public func getTopStories(_ completion: @escaping (Query?)->()) {
            guard let url = urlPath else { return }
        URLSession.shared.dataTask(with: url) {
                data, response, error in
                if let data = data {
                    let array = try? JSONDecoder().decode(Article.self, from: data).articles
                    completion(Query.success(articles: array ?? []))
                }
            }.resume()
    }
}

enum Query {
    case success(articles: [Article.Data])
    case failure(error: Error)
}

struct Article: Codable {
    let articles: [Data]
    struct Data: Codable {
        let title: String
        let articleDescription: String?
        let url: String
        let urlToImage: String?
        enum CodingKeys: String, CodingKey {
            case title
            case articleDescription = "description"
            case url
            case urlToImage
        }
    }
}


    


