import Foundation


struct Group {
    var title: String
    var subtitle: String
    var image: String?
}

extension Group{
        static var WGroups: [Group]{
            return[
                Group(title: "Усы Пескова", subtitle: "Юмор", image: photos[0]),
                Group(title: "GU_iOS_1062", subtitle: "Дискуссионный клуб", image: photos[1]),
                Group(title: "Подслушено МГУ", subtitle: "Юмор", image: photos[2]),
                Group(title: "MARVEL/DC", subtitle: "Кино", image: photos[3]),
                Group(title: "Лайфхак", subtitle: "Юмор", image: photos[4])
            ]
        }
    static func imageView() -> String{
        return String(Int.random(in: 1...9))
    }
}

var photos: [String] = [Group.imageView(),Group.imageView(),Group.imageView(),Group.imageView(),Group.imageView()]

