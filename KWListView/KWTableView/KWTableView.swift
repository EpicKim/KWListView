//
//  KWTableView.swift
//  TableViewDemo
//
//  Created by Lich King on 16/3/6.
//  Copyright © 2016年 Lich King. All rights reserved.
//

import UIKit

class KWTableViewCell: UITableViewCell,KWListProtocal {
    func update(_ item: NSObject) {
        
    }
}

class KWTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    fileprivate var cellIdentifier = "kwCell"
    fileprivate var tableViewCellClass:AnyClass!
    fileprivate var datasource:[NSObject]!
    var designedCellHeight:CGFloat!
    var clickBlock:(_ item:NSObject,_ indexPath:IndexPath)->Void = {_ in}
    convenience init(tableViewCellClass:AnyClass,datasource:[NSObject],designedCellHeight:CGFloat) {
        self.init(frame:CGRect.zero)
        self.designedCellHeight = designedCellHeight
        self.datasource = datasource
        self.tableViewCellClass = tableViewCellClass
        self.setup()
    }

    func setup() {
        self.register(self.tableViewCellClass, forCellReuseIdentifier: cellIdentifier)
        self.delegate = self
        self.dataSource = self
    }
    
    // MAKR: -Public
    func update(_ item: NSObject,index:Int) {
        // TODO: 需要加入对多section的支持
        let cell = self.cellForRow(at: IndexPath(row: index, section: 0)) as! KWTableViewCell
        cell.update(item)
    }
    
    // UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.designedCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KWTableViewCell
        let item = self.datasource[indexPath.row]
        cell.update(item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: true)
        let item = self.datasource[indexPath.row]
        self.clickBlock(item, indexPath)
    }
}
