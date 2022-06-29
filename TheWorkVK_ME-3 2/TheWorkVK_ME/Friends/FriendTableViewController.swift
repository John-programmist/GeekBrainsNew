//
//  FriendTableViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 07.12.2021.
//

import UIKit
import RealmSwift

class FriendTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var search: Bool = true
	var friends: [FriendSection] = []
	var filteredFriends: [FriendSection] = []
	var lettersOfNames: [String] = []
	var service = FriendsServiceManager()
    
    var mainFriend = [Friend]()
    private var notificationToken: NotificationToken?
    private lazy var realm = RealmCacheServer()
    

    override func viewDidLoad() {
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MainHeader")
        super.viewDidLoad()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.sectionHeaderHeight = 50.0
        searchBar.delegate = self
        makeObserver(realm: realm)
        fetchFriends()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            UIView.animate(withDuration: 0, animations: self.searchBarAnimateClosure())
        })
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredFriends[section].data.count
	}
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = friends[section]

        return String(section.key)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell123",
                                                     for: indexPath) as? FriendCellTableViewCell
        else {
            return UITableViewCell()
        }

        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 10

        let section = filteredFriends[indexPath.section]
        let name = section.data[indexPath.row].firstName + " " + section.data[indexPath.row].lastName
        let photo = section.data[indexPath.row].photo50
        cell.title.text = name

        service.loadImage(url: photo) { image in
            cell.photo.image = image
        }

        return cell
    }
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {//Главнее всегда
        return createHeaderView(section: section)
	}

	override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return lettersOfNames
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is FriendCollectionViewController {
			guard
				let prepare = segue.destination as? FriendCollectionViewController,
				let indexPathSection = tableView.indexPathForSelectedRow?.section,
				let indexPathRow = tableView.indexPathForSelectedRow?.row
			else {
				return
			}
			let section = filteredFriends[indexPathSection]
            prepare.certainPerson = section.data[indexPathRow].firstName + " " + section.data[indexPathRow].lastName
            prepare.certainPhoto = section.data[indexPathRow].photo100
//                        vc.friend = section.data[indexPathRow]
//			            guard let image = UIImage(named: section.data[indexPathRow].storedImages) else { return }
//			            vc.photos = image
		}
	}
}


extension FriendTableViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		filteredFriends = []

		if searchText == "" {
			filteredFriends = friends
		} else {
			for section in friends {
				for (_, friend) in section.data.enumerated() {
					if friend.firstName.lowercased().contains(searchText.lowercased()) {
						var searchedSection = section

						if filteredFriends.isEmpty {
							searchedSection.data = [friend]
							filteredFriends.append(searchedSection)
							break
						}
						var found = false
						for (sectionIndex, filteredSection) in filteredFriends.enumerated() {
							if filteredSection.key == section.key {
								filteredFriends[sectionIndex].data.append(friend)
								found = true
								break
							}
						}
						if !found {
							searchedSection.data = [friend]
							filteredFriends.append(searchedSection)
						}
					}
				}
			}
		}
		self.tableView.reloadData()
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		self.searchBar.showsCancelButton = true // показать кнопку кансл

		let cBtn = searchBar.value(forKey: "cancelButton") as! UIButton
		cBtn.backgroundColor = .lightGray
		cBtn.setTitleColor(.white, for: .normal)

		UIView.animate(withDuration: 0.3,
					   animations: {
			// Двигаем кнопку кансл
			cBtn.frame = CGRect(x: cBtn.frame.origin.x - 50,
								y: cBtn.frame.origin.y,
								width: cBtn.frame.width,
								height: cBtn.frame.height)

			// Анимируем запуск поиска. -1 чтобы пошла анимация, тогда лупа плавно откатывается
			self.searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
										  y: self.searchBar.frame.origin.y,
										  width: self.searchBar.frame.size.width - 1,
										  height: self.searchBar.frame.size.height)
			self.searchBar.layoutSubviews()
		})
        
        
	}
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.showsCancelButton = false
        
    }
    
    
    
}

// MARK: - Private
private extension FriendTableViewController {
    
    func loadLetters() {
        for user in friends {
            lettersOfNames.append(String(user.key))
        }
    }
    
    func fetchFriends() {
        service.loadFriends { [weak self] friends in
            guard let self = self else { return }
            self.friends = friends
            self.filteredFriends = friends
            self.loadLetters()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

	func createHeaderView(section: Int) -> UIView {
		let header = GradientView()
        header.startColor = .systemPink
        header.endColor = .systemPink

		let letter = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
		letter.textColor = .white
		letter.text = lettersOfNames[section]
		letter.font = UIFont.systemFont(ofSize: 14)
		header.addSubview(letter)
		return header
	}

	func searchBarAnimateClosure () -> () -> Void {
		return {
			guard
				let scopeView = self.searchBar.searchTextField.leftView,
				let placeholderLabel = self.searchBar.textField?.value(forKey: "placeholderLabel") as?
					UILabel
			else {
				return
			}

			UIView.animate(withDuration: 0.3,
			animations: {
				scopeView.frame = CGRect(x: self.searchBar.frame.width / 2 - 15,
										 y: scopeView.frame.origin.y,
										 width: scopeView.frame.width,
										 height: scopeView.frame.height)
				placeholderLabel.frame.origin.x -= 20
				self.searchBar.layoutSubviews()
			})
		}
	}
    
    private func makeObserver(realm: RealmCacheServer){
        
        var objc: Results<Friend> {
            realm.read(Friend.self)
        }
        
        notificationToken = objc.observe({ changes in
            switch changes{
            case let .initial(objc):
                self.mainFriend = Array(objc)
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            case let .update(friends, deletions, insertions, modifications):
                DispatchQueue.main.async {
                    [self] in
                    print("Произошло изменение")
                    self.mainFriend = Array(friends)
                    let deletionIndex = deletions.reduce(into: IndexSet(), {$0.insert($1)})
                    let insertIndex = insertions.reduce(into: IndexSet(), {$0.insert($1)})
                    let modiIndex = modifications.reduce(into: IndexSet(), {$0.insert($1)})
                    
                    tableView.beginUpdates()
                    
                    tableView.deleteSections(deletionIndex, with: .automatic)
                    tableView.insertSections(insertIndex, with: .automatic)
                    tableView.reloadSections(modiIndex, with: .automatic)
                    
                    tableView.endUpdates()
                }
            }
        })
    }
}
