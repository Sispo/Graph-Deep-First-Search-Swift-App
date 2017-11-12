//
//  AdjListVC.swift
//  GraphDeepFirstSearch
//
//  Created by Tymofii Dolenko on 11/12/17.
//  Copyright © 2017 Tymofii Dolenko. All rights reserved.
//

import UIKit

class AdjListVC: UIViewController {
    
    var adjList : [EdgeList] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension AdjListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adjList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            let current = adjList[indexPath.row]
            var desc = "[\(current.vertex.index)] "
            for edge in current.edges {
                desc += edge.desc
            }
            cell.textLabel?.text = desc
            return cell
        }
        
        return UITableViewCell()
    }
    
}
