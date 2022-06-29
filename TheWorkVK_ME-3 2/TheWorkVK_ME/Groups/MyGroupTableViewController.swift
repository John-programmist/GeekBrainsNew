//
//  MyGroupTableViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 07.12.2021.
//

import UIKit
import RealmSwift

class MyGroupTableViewController: UITableViewController {
    
    var groupSection: [GroupSection] = []

    var allGroups: [String] = []
    
    var allGroupsContent: [String] = []
    
    var allPhotos: [String?] = []
    
    private let serviceGroup = GroupVKService()
    
    private lazy var realm = RealmCacheServer()
    private var groupResponse: Results<Groups>? {
        realm.read(Groups.self)
    }
    
     private var notificationToken: NotificationToken?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createNotificationGroupToken()
        getUserGroupList()
    }
    
    
    @IBAction func unwindSegueFromAllGroup(_ segue: UIStoryboardSegue){
//        guard
//            let controller = segue.source as? AllGroupTableViewController,
//            let indexPath = controller.tableView.indexPathForSelectedRow
//        else {return}
//
//        let group = controller.groups[indexPath.row]
//        let title = group.data[indexPath.row].name
//        let subtitle = group.data[indexPath.row].type
//        let photo = group.data[indexPath.row].photo50
//
//        if allGroups.contains(title){
//            return
//        }
//
//        allGroups.append(title)
//        allGroupsContent.append(subtitle)
//        allPhotos.append(photo)
//        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? MyGroupCollection,
//           let indexPath = tableView.indexPathForSelectedRow{
//            controller.certainGroup = allGroups[indexPath.row]
//            controller.certainPhoto = allPhotos[indexPath.row]
//        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupResponse?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupCellTableViewCell
        if let groups = groupResponse {
            cell.configure(group: groups[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let _ = groupSection[indexPath.section]
//            section.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

private extension MyGroupTableViewController{
//    func fetchGroups() {
//        serviceGroup.loadGroup { [weak self] groups in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.groupSection = groups
//                self.tableView.reloadData()
//            }
//        }
//    }
    
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
                
                

                    self.tableView.beginUpdates()

                    self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.tableView.endUpdates()
                
                
            case .error(let error):
                print("\(error)")
            }
        }
    }
}

