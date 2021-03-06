//
//  AmiiboCell.swift
//  ultimateTableView
//
//  Created by Mikaela Caron on 3/9/19.
//  Copyright © 2019 Mikaela Caron. All rights reserved.
//

import UIKit


class AmiiboCell: UITableViewCell {
    
    var safeArea: UILayoutGuide!
    
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    let owningCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setupView() {
        
        safeArea = layoutMarginsGuide
        setupOwningCountLabel()
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
        
    }//end setupView()
    
    func setupImageView() {
        addSubview(imageIV)
        
        imageIV.contentMode = .scaleAspectFit
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo: owningCountLabel.trailingAnchor, constant: 5).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //imageIV.backgroundColor = .red
        
    }//end setupImageView()
    
    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        
    }//end setupNameLabel()
    
    func setupGameSeriesLabel() {
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        gameSeriesLabel.font = UIFont(name: "Verdana", size: 14)
        
    }//end setupGameSeriesLabel()
    
    func setupOwningCountLabel() {
        addSubview(owningCountLabel)
        
        owningCountLabel.translatesAutoresizingMaskIntoConstraints = false
        owningCountLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        owningCountLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        
    } //end setupOwningCountLabel()
    
}//end AmiiboCell class
