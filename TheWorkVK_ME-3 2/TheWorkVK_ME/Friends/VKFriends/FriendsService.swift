//
//  FriendsService.swift
//  TheWorkVK_ME
//
//  Created by Roman on 17.01.2022.
//
import Foundation

enum FriendsError: Error {
    case parseError
    case requestError(Error)
}

fileprivate enum TypeMethods: String {
    case friendsGet = "/method/friends.get"
}

fileprivate enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

final class FriendsService {
    private let scheme = "https"
    private let host = "api.vk.com"
    

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    func loadFriend(completion: @escaping ((Result<FriendsVK, FriendsError>) -> ())) {
        let token = Session.instance.token 
        let params: [String: [String]] = ["v": ["5.81"],
                                        "fields": ["photo_50", "photo_100"]
        ]

        let url = configureUrl(token: token,
                               method: .friendsGet,
                               htttpMethod: .get,
                               params: params)
        

        
        print(url)
        
        let task = session.dataTask(with: url) { data, _ , error in
            if let error = error {
				return completion(.failure(.requestError(error)))
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(FriendsVK.self, from: data)
                print(result)
                return completion(.success(result))
            } catch {
                return completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

private extension FriendsService {
    func configureUrl(token: String,
                      method: TypeMethods,
                      htttpMethod: TypeRequests,
                      params: [String: [String]]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.131"))

        for (param, value) in params {
            if(value.count>1){
                queryItems.append(URLQueryItem(name: param, value: value[0]+","+value[1]))
            }
            else{
                queryItems.append(URLQueryItem(name: param, value: value[0]))
            }
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        return url
    }
}

