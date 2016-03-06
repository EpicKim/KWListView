//
//  KWTableView.swift
//  TableViewDemo
//
//  Created by Lich King on 16/3/6.
//  Copyright © 2016年 Lich King. All rights reserved.
//

import UIKit

class KWTableViewCell: UITableViewCell,KWListProtocal {
    func update(item: KWListDatasourceItem) {
        
    }
}

class KWTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private var cellIdentifier = "kwCell"
    private var tableViewCellClass:AnyClass!
    private var datasource:[KWListDatasourceItem]!
    var clickBlock:(item:KWListDatasourceItem,indexPath:NSIndexPath)->Void = {_ in}
    convenience init(tableViewCellClass:AnyClass,datasource:[KWListDatasourceItem]) {
        self.init(frame:CGRectZero)
        
        self.datasource = datasource
        self.tableViewCellClass = tableViewCellClass
        self.setup()
    }

    func setup() {
        self.registerClass(self.tableViewCellClass, forCellReuseIdentifier: cellIdentifier)
        self.delegate = self
        self.dataSource = self
    }
    
    // MAKR: -Public
    func update(item: KWListDatasourceItem,index:Int) {
        // TODO: 需要加入对多section的支持
        let cell = self.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! KWTableViewCell
        cell.update(item)
    }
    
    // UITableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! KWTableViewCell
        let item = self.datasource[indexPath.row]
        cell.update(item)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.deselectRowAtIndexPath(indexPath, animated: true)
        let item = self.datasource[indexPath.row]
        self.clickBlock(item: item, indexPath: indexPath)
    }
}
