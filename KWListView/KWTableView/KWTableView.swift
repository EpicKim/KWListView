//
//  KWTableView.swift
//  TableViewDemo
//
//  Created by Lich King on 16/3/6.
//  Copyright © 2016年 Lich King. All rights reserved.
//

import UIKit

extension UITableViewCell:KWListProtocal {
    func update(_ item: Any) {
        
    }
}

class KWTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var cellIdentifier = "kwCell"
    fileprivate var tableViewCellClass:AnyClass!
    fileprivate var datasource:[Any]!
    
    var designedCellHeight:CGFloat!
    var clickBlock:(_ item:Any,_ indexPath:IndexPath)->Void = {_ in}
    
    convenience init(tableViewCellClass:AnyClass,
                     datasource:[Any],
                     designedCellHeight:CGFloat) {
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
    /// 更新单个cell
    ///
    /// - Parameters:
    ///   - item: 更新的数据结构
    ///   - index: -
    func update(_ item: Any,
                index:Int) {
        // TODO: 需要加入对多section的支持
        let cell = self.cellForRow(at: IndexPath(row: index, section: 0))
        cell!.update(item)
    }
    
    // MARK: -UITableView Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return designedCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = self.datasource[indexPath.row]
        cell.update(item)
        
        return cell
    }
    // MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: true)
        let item = self.datasource[indexPath.row]
        clickBlock(item, indexPath)
    }
}
