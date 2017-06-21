//
//  KWCollectionView.swift
//  lottery
//  CollectionView基类
//  Created by wangk on 16/3/3.
//  Copyright © 2016年 CP. All rights reserved.
//

import UIKit

protocol KWCollectionViewCellProtocol {
    func update(_ item: Any)
}

class KWCollectionViewCell:UICollectionViewCell,KWCollectionViewCellProtocol {
    func update(_ item: Any) {}
}

class KWCollectionView: UICollectionView,UICollectionViewDelegate, UICollectionViewDataSource {
    var datasource:[Any]!
    var collectionViewClass:AnyClass!
    var clickClosure:(_ item:Any, _ indexPath:IndexPath)->Void = {_ in }
    convenience init(itemWidth:Int, height:Int, minimumLineSpacing:CGFloat, minimumInteritemSpacing:CGFloat, collectionViewClass:AnyClass, datasource:[Any]) {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: height)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.sectionInset = UIEdgeInsetsMake(0,1,0,1)
        flowLayout.minimumLineSpacing = minimumLineSpacing//每个相邻layout的上下
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing//每个相邻layout的左右
        flowLayout.headerReferenceSize = CGSize(width: 0,height: 0);
        self.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.datasource = datasource
        
        self.isScrollEnabled = false
        self.backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.register(collectionViewClass, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: -Public 
    func update(_ datasource : [Any]) {
        if(datasource.count == 0) {
            return 
        }
        self.datasource = datasource
        self.reloadData()
    }
    // MARK: -CollectionView Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionViewContentSize() -> CGSize {
        return CGSize(width: 50, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.datasource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! KWCollectionViewCell
        cell.update(item)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.datasource[indexPath.row]
        self.clickClosure(item, indexPath)
    }
}
