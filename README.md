# KWListView
对TableView的轻量级封装

1.一句代码就能轻松的初始化一个tableView
```objc
let datasource = [MyItem(name: "collectionViewDemo"),
                        MyItem(name: "second"),
                        MyItem(name: "third")]
tableView = KWTableView(tableViewCellClass: MyTableViewCell.self, datasource: datasource,designedCellHeight: 60)
```

2.TableViewCell需要继承KWTableViewCell,重写update来实现数据更新
```objc
override func update(item: NSObject)
{
  let myItem = item as! MyItem
  self.myLabel.text = myItem.name
}
```
3.使用block来获取点击事件
```objc
tableView.clickBlock = {(item,indexPath) -> Void in
  let myItem = item as! MyItem
  print(myItem.name)
}
```
