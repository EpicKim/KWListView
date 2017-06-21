//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Lich King on 16/3/6.
//  Copyright © 2016年 Lich King. All rights reserved.
//

import UIKit

class MyTableViewCell:UITableViewCell {
    fileprivate let myLabel:UILabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(myLabel)
        
        myLabel.frame = CGRect(x: 20, y: 0, width: 100, height: 40)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func update(_ item: Any) {
        let myItem = item as! MyItem
        self.myLabel.text = myItem.name
    }
}

class MyItem : Any {
    var name:String!
    convenience init(name:String) {
        self.init()
        self.name = name
    }
}

class ViewController: UIViewController {
    var tableView:KWTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        let datasource = [MyItem(name: "first"),
                          MyItem(name: "second"),
                          MyItem(name: "third"),
                          MyItem(name: "forth"),
                          MyItem(name: "fifth"),
                          MyItem(name: "sixth"),
                          MyItem(name: "senventh")]
        tableView = KWTableView(tableViewCellClass: MyTableViewCell.self, datasource: datasource,designedCellHeight: 60)
        tableView.clickBlock = {(item,indexPath) -> Void in
            let myItem = item as! MyItem
            print(myItem.name)
        }
        self.view.addSubview(tableView)
        
        tableView.frame = CGRect(x: 0, y: 30, width: 320, height: 500)
        
        // test update
        let testButton = UIButton(type: .system)
        testButton.setTitle("点我吧", for: UIControlState())
        testButton.addTarget(self, action: #selector(ViewController.click), for: .touchUpInside)
        self.view.addSubview(testButton)
        testButton.frame = CGRect(x: 100, y: 500, width: 100, height: 40)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func click() {
        // TEST ALTER
        tableView.update(MyItem(name: "updated"), index: 0)
    }
}

