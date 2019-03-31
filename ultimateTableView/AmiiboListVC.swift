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
    var amiiboList = [AmiiboForView ]()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupView()
        
        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in
            DispatchQueue.main.async {
                let amiiboForViewList = fetchedAmiiboList.map {amiibo in
                    return AmiiboForView(
                        name: amiibo.name,
                        gameSeries: amiibo.gameSeries,
                        imageUrl: amiibo.image,
                        count: 0
                    )
                }
                self.amiiboList = amiiboForViewList
                self.tableView.reloadData()
            }
        }
        
         AmiiboAPI.shared.fetchAmiiboList(onComplete: anonymousFunction)
        
    }//end viewDidLoad()
    
    //MARK: - Setup View
    func setupView() {
        //ALWAYS add the UIView FIRST before setting contraints
        view.addSubview(tableView)
        
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        guard let amiiboCell = cell as? AmiiboCell else {
            return cell
        }
        
        amiiboCell.nameLabel.text = amiibo.name
        amiiboCell.gameSeriesLabel.text = amiibo.gameSeries
        amiiboCell.owningCountLabel.text = String(amiibo.count)
        
        if let url = URL(string: amiibo.imageUrl) {
            amiiboCell.imageIV.loadImage(from: url)
        }
        
        return cell
    }
    
}//end AmiiboListVC: UITableViewDataSource

//MARK:- UITableViewDelegate

extension AmiiboListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction (style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            //remove from data layer
            self.amiiboList.remove(at: indexPath.row)
            //remove from presentation layer
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
            
        }//end deleteAction
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }//end trailingSwipeActionsConfigurationForRowAt
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let countAction = UIContextualAction(style: .normal, title: "Count Up") { (action, view, completionHandler) in
            
            //manipulating the data layer
            let currentCount = self.amiiboList[indexPath.row].count
            self.amiiboList[indexPath.row].count = currentCount + 1
            
            //manipulating the presentation layer
            if let cell = self.tableView.cellForRow(at: indexPath) as? AmiiboCell {
                cell.owningCountLabel.text = String(self.amiiboList[indexPath.row].count)
            }
            
            completionHandler(true)
            
        }//end countAction
        
        return UISwipeActionsConfiguration(actions: [countAction])
    }//end leadingSwipActionsConfigurationForRowAt
    
}//end AmiiboListVC: UITableViewDelegate
