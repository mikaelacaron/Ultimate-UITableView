//
//  ViewController.swift
//  ultimateTableView
//
//  Created by Mikaela Caron on 3/1/19.
//  Copyright © 2019 Mikaela Caron. All rights reserved.
//

import UIKit

class AmiiboListVC: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var amiiboList = [Amiibo]()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupView()
        
        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in
            DispatchQueue.main.async {
                self.amiiboList = fetchedAmiiboList
                self.tableView.reloadData()
            }
        }
        
         AmiiboAPI.shared.fetchAmiiboList(onComplete: anonymousFunction)
        
    }//end viewDidLoad()
    
    //MARK: - Setup View
    func setupView() {
        //ALWAYS add the UIView FIRST before setting contraints
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }//end setupView()
    
}

//MARK: - UITableViewDataSource

extension AmiiboListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let amiibo = amiiboList[indexPath.row]
        
        cell.textLabel?.text = amiibo.name
        return cell
    }
    
}//end AmiiboListVC: UITableViewDataSource
