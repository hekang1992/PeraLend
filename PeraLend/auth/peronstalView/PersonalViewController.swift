//
//  PersonalViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit

class PersonalViewController: BaseViewController {
    
    var productID: String = ""
    
    lazy var personView: PersonalView = {
        let personView = PersonalView()
        personView.tableView.delegate = self
        personView.tableView.dataSource = self
        return personView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(personView)
        personView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        personView.headView.backBlock = { [weak self] in
            self?.popToSelectController()
        }
        
    }


}

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}
