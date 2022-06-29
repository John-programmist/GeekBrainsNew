//
//  RealmCacheServer.swift
//  TheWorkVK_ME
//
//  Created by Roman on 13.02.2022.
//

import Foundation
import RealmSwift
import SwiftUI
import Alamofire

class RealmCacheServer {
    enum ErrorsFromCache:Error{
        case noRealmObject(String)
        case noPrimaryKeys(String)
        case failedToRead(String)
    }
    
    /// Объект хранилища
    var realm: Realm

    init() {
        do {
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        self.realm = try Realm()//configuration: config)
            print(realm.configuration.fileURL ?? "")
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func create<T: Object>(_ object: T) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(object, update: .modified)
                }
            } catch {
                print(error)
            }
        }
    }


    func create<T: Object>(_ objects: [T]) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(objects, update: .modified)
                }
            } catch {
                print(error)
            }
        }
    }

    func read<T: Object>(_ object: T.Type, key: String = "", completion: (Result<T, Error>) -> Void) {

        if let result = realm.object(ofType: T.self, forPrimaryKey: key) {
            completion(.success(result))
        } else {
            completion(.failure(ErrorsFromCache.failedToRead("Could not read such object")))
        }
    }

    func read<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }

    func update<T: Object>(_ object: T, completion: (Result<Bool, Error>) -> Void) {

        guard let _ = T.primaryKey() else {
            completion(.failure(ErrorsFromCache.noPrimaryKeys("This model does not have a primary key")))
            return
        }

        do {
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func delete<T: Object>(_ object: T.Type, keyValue: String, completion: (Result<Bool, Error>) -> Void) {

        guard let primaryKey = T.primaryKey() else {
            completion(.failure(ErrorsFromCache.noPrimaryKeys("This model does not have a primary key")))
            return
        }

        guard let object = realm.objects(T.self).filter("\(primaryKey) = %@", Int(keyValue)!).first else {
            completion(.failure(ErrorsFromCache.noRealmObject("There is no such object")))
            return
        }

        do {
            realm.beginWrite()
            realm.delete(object)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func delete<T: Object>(_ object: T.Type, completion: (Result<Bool, Error>) -> Void) {
        let oldData = realm.objects(T.self)

        do {
            realm.beginWrite()
            realm.delete(oldData)
            try realm.commitWrite()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }

    func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try? realm.commitWrite()
    }
}
