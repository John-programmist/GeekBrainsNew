//
//  AllGroupTableViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 07.12.2021.
//

import UIKit
import RealmSwift

class AllGroupTableViewController: UITableViewController {

    var groups: [Groups] = []
    
    var groupSection: [GroupSection] = []
    
    private let serviceGroup = GroupVKService()
    
    private lazy var realm = RealmCacheServer()
    private var groupResponse: Results<Groups>? {
        realm.read(Groups.self)
    }
    
    var notificationToken: NotificationToken?
    
    
    override func viewDidLoad() {
        getUserGroupList()
        createNotificationGroupToken()
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! AllGroupCellTableViewCell
        if let groups = groupResponse {
            cell.configure(group: groups[indexPath.row])
        }
        return cell
    }
    
    func getUserGroupList(){
        serviceGroup.loadGroup { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    func createNotificationGroupToken(){
        notificationToken = groupResponse?.observe{ [weak self] result in
            guard let self = self else { return }
            switch result{
            case .initial(let groupData):
                print("init with \(groupData.count) groups")
            case .update(let groups,
                         deletions: let deletetions,
                         insertions: let insertions,
                         modifications: let modifications):
                print("""
new count \(groups.count)
deletions \(deletetions)
insertions \(insertions)
modifications \(modifications)
""")
                let deletionsIndexPath = deletetions.map { IndexPath(row: $0, section: $0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: $0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: $0) }
                
                DispatchQueue.main.async {

                    self.tableView.beginUpdates()

                    self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.tableView.endUpdates()
                }
                
            case .error(let error):
                print("\(error)")
            }
        }
    }

}
