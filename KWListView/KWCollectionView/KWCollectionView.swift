//
//  KWCollectionView.swift
//  lottery
//  CollectionView基类
//  Created by wangk on 16/3/3.
//  Copyright © 2016年 CP. All rights reserved.
//

import UIKit

protocol KWCollectionViewCellProtocol {
    func update(item: NSObject)
}

class KWCollectionViewCell:UICollectionViewCell,KWCollectionViewCellProtocol {
    func update(item: NSObject) {}
}

class KWCollectionView: UICollectionView,UICollectionViewDelegate, UICollectionViewDataSource {
    var datasource:[NSObject]!
    var collectionViewClass:AnyClass!
    var clickClosure:(item:NSObject, indexPath:NSIndexPath)->Void = {_ in }
    convenience init(itemWidth:Int, height:Int, minimumLineSpacing:CGFloat, minimumInteritemSpacing:CGFloat, collectionViewClass:AnyClass, datasource:[NSObject]) {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: height)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.sectionInset = UIEdgeInsetsMake(0,1,0,1)
        flowLayout.minimumLineSpacing = minimumLineSpacing//每个相邻layout的上下
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing//每个相邻layout的左右
        flowLayout.headerReferenceSize = CGSizeMake(0,0);
        self.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        self.datasource = datasource
        
        self.scrollEnabled = false
        self.backgroundColor = UIColor.clearColor()
        self.delegate = self
        self.dataSource = self
        self.registerClass(collectionViewClass, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: -Public 
    func update(datasource : [NSObject]) {
        if(datasource.count == 0) {
            return 
        }
        self.datasource = datasource
        self.reloadData()
    }
    // MARK: -CollectionView Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionViewContentSize() -> CGSize {
        return CGSize(width: 50, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = self.datasource[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! KWCollectionViewCell
        cell.update(item)

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let item = self.datasource[indexPath.row]
        self.clickClosure(item: item, indexPath: indexPath)
    }
}
