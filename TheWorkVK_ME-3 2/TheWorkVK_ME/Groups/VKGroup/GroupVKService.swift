//
//  GroupVKService.swift
//  TheWorkVK_ME
//
//  Created by Roman on 24.01.2022.
//

import Foundation
import RealmSwift

enum GroupError: Error {
    case parseError
    case requestError(Error)
}

fileprivate enum TypeMethods: String {
    case groupsGet = "/method/groups.get"
    case groupsSearch = "/method/groups.search"
    case groupsJoin = "/method/groups.join"
    case groupsLeave = "/method/groups.leave"
}

fileprivate enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

final class GroupVKService {
    
    private var realm = RealmCacheServer()
    
    private let scheme = "https"
    private let host = "api.vk.com"
    private let cacheKey = "groups"
    
    private let decoder = JSONDecoder()

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    func loadGroup(completion: @escaping (Result<[Groups], GroupError>) -> Void) { 
        if checkExpiry(key: cacheKey) {
            guard let realm = try? Realm() else { return }
            let groups = realm.objects(Groups.self)
            let groupsArray = Array(groups)

            if !groups.isEmpty {
                completion(.success(groupsArray))
                return
            }
        }

        let token: String = Session.instance.token
        let params: [String: String] = ["extended": "1"]

        let url = configureUrl(token: token,
                               method: .groupsGet,
                               htttpMethod: .get,
                               params: params)

        print(url)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(GroupVK.self, from: data).response.items

                DispatchQueue.main.async {
                    self.realm.create(result)
                }

                return completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    func loadGroupSearch(searchText: String, completion: @escaping(Result<[Groups], GroupError>) -> Void) {
        let token = Session.instance.token 
        let params: [String: String] = ["extended": "1",
                                        "q": searchText,
                                        "count": "40"]
        let url = configureUrl(token: token,
                               method: .groupsSearch,
                               htttpMethod: .get,
                               params: params)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(GroupVK.self, from: data)
                return completion(.success(result.response.items))
            } catch {
                return completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    func addGroup(idGroup: Int, completion: @escaping(Result<JoinOrLeaveGroupModel, GroupError>) -> Void) {
        let token = Session.instance.token
        let params: [String: String] = ["group_id": "\(idGroup)"]
        let url = configureUrl(token: token,
                               method: .groupsJoin,
                               htttpMethod: .post,
                               params: params)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(JoinOrLeaveGroupModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }

    func deleteGroup(id: Int, completion: @escaping(Result<JoinOrLeaveGroupModel, GroupError>) -> Void) {
        let token = Session.instance.token

        let params: [String: String] = ["group_id": "\(id)"]

        let url = configureUrl(token: token,
                               method: .groupsJoin,
                               htttpMethod: .post,
                               params: params)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }
            guard let data = data else {
                return
            }
            do {
                let result = try self.decoder.decode(JoinOrLeaveGroupModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

private extension GroupVKService {
    func configureUrl(token: String,
                      method: TypeMethods,
                      htttpMethod: TypeRequests,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.131"))

        for (param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
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
    
    /// Проверяет, свежие ли данные, true - всё хорошо
    func checkExpiry(key: String) -> Bool {
        let expiryDate = UserDefaults.standard.string(forKey: key) ?? "0"
        let currentDate = String(Date.init().timeIntervalSince1970)

        if expiryDate > currentDate {
            return true
        } else {
            return false
        }
    }
}


