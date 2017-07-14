//
//  ADTableView.swift
//  lottery
//  改进版的tableView
//  Created by wangk on 2017/7/6.
//  Copyright © 2017年 CP. All rights reserved.
//

import Foundation
import UIKit

protocol ADListProtocal {
    func update(_ item: Any)
}

extension UITableViewCell:ADListProtocal {
    func update(_ item: Any) {
        
    }
}

struct ADListItem {
    var userInfo:Any!
    var cellClass:AnyClass!
    var action:(()->Void) = {_ in}
}

class ADTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var cellIdentifier = "kwAdvancedCell"
    fileprivate var datasource:[[ADListItem]]!
    
    var designedCellHeight:CGFloat!
    var clickBlock:(_ item:Any,_ indexPath:IndexPath)->Void = {_ in}
    var getPlaceHolderView:()->UIView = {_ in return UIView()}
    var placeHolderView:UIView?
    
    convenience init(datasource:[[ADListItem]],
                     designedCellHeight:CGFloat) {
        if datasource.count == 1 {
            self.init(frame:CGRect.zero)
        }
        else {
            self.init(frame: CGRect.zero, style: .grouped)
        }
        
        self.designedCellHeight = designedCellHeight
        self.datasource = datasource
        self.setup()
    }
    
    func setup() {
        var registed = [AnyClass]()
        for items in datasource {
            for item in items {
                let isRegist = registed.contains(where: { (type) -> Bool in
                    return item.cellClass == type
                })
                if !isRegist {
                    let identifier = NSStringFromClass(item.cellClass)
                    self.register(item.cellClass, forCellReuseIdentifier: identifier)
                    registed.append(item.cellClass)
                }
            }
        }
        self.delegate = self
        self.dataSource = self
    }
    
    // MAKR: -Public
    func kw_reload() {
        if datasource.count == 0 {
            if placeHolderView == nil {
                placeHolderView = getPlaceHolderView()
                self.addSubview(placeHolderView!)
            }
        }
        else {
            placeHolderView?.removeFromSuperview()
            placeHolderView = nil
        }
        self.reloadData()
    }
    /// 更新单个cell
    ///
    /// - Parameters:
    ///   - item: 更新的数据结构
    ///   - index: -
    func update(_ userInfo: Any,
                row:Int,
                section:Int) {
        // TODO: 需要加入对多section的支持
        let indexPath = IndexPath(row: row, section: section)
        let cell = self.cellForRow(at: indexPath)
        
        datasource[section][row].userInfo = userInfo
        cell!.update(userInfo)
    }
    
    // MARK: -UITableView Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return designedCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.section][indexPath.row]
        let identifier = NSStringFromClass(item.cellClass)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.update(item.userInfo)
        
        return cell
    }
    // MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: true)
        let item = self.datasource[indexPath.section][indexPath.row]
        
        item.action()
        clickBlock(item.userInfo, indexPath)
    }
}
