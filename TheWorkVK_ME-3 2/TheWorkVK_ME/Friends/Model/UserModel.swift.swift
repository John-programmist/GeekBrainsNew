import UIKit


struct User {
    var name: [String]
    var image: String?
    
    var uiImage: UIImage = UIImage()
    var storedImages: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!]
    
    init(name: [String], image: String?, storedImages: [String]) {
        self.name = name
        self.image = image

        if image != nil{
            uiImage = UIImage(named: image!) ?? UIImage()
        }
        else{
            uiImage = UIImage(systemName: "person.fill") ?? UIImage()
        }

        // Собираем массив фоток юзера из имён фоток
        for storedImage in storedImages {
            guard let image = UIImage(named: storedImage) else { continue }
            self.storedImages.append(image)
        }
    }
}

extension User{
    static var person: [User]{
        return[
            User(name: ["T","homas"], image: Person[0], storedImages: []),
            User(name: ["J","ohn"], image: nil, storedImages: []),
            User(name: ["T","anya"], image: Person[2], storedImages: []),
            User(name: ["A","lex"], image: Person[3], storedImages: [])
        ]
    }
    
    static func imageView() -> String{
        return String(Int.random(in: 1...9))
    }
    
    //    static func iNeedFriends() -> [FriendsSection] {
    //        let sortedArray = sortFriends(array: friends)
    //        let sectionsArray = formFriendsSection(array: sortedArray)
    //        return sectionsArray
    //    }
    //
    //
    //    static func sortFriends(array: [FriendModel]) -> [Character: [FriendModel]] {
    //        var newArray: [Character: [FriendModel]] = [:]
    //
    //        for friend in array {
    //            guard let firstChar = friend.name.first else {
    //                continue
    //            }
    //
    //            guard var array = newArray[firstChar] else {
    //                let newValue = [friend]
    //                newArray.updateValue(newValue, forKey: firstChar)
    //                continue
    //            }
    //
    //            array.append(friend)
    //
    //            newArray.updateValue(array, forKey: firstChar)
    //        }
    //        return newArray
    //    }
    //
    //    static func formFriendsSection(array: [Character: [FriendModel]]) -> [FriendsSection] {
    //        var sectionsArray: [FriendsSection] = []
    //
    //        for (key, array) in array {
    //            sectionsArray.append(FriendsSection(key: key, data: array))
    //        }
    //        sectionsArray.sort { $0 < $1 }
    //
    //        return sectionsArray
    //    }
}

var Person: [String] = [User.imageView(), User.imageView(), User.imageView(), User.imageView(), User.imageView()]
