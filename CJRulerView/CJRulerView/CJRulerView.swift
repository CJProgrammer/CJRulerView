//
//  CJRulerView.swift
//  Swift65
//
//  Created by CJ on 2017/6/5.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class CJRulerView: UIView ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    var items:Array<String>!
    
    let kItemWidth:CGFloat = 80.0
    let kItemWidthHalf:CGFloat = 40.0
    let kItemHeight:CGFloat = 60.0
    
    var collectionView:UICollectionView?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let flowLayout = UICollectionViewFlowLayout();
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSize(width:kItemWidth,height:kItemHeight)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.sectionInset = UIEdgeInsetsMake(0, self.bounds.width / 2, 0, self.bounds.width / 2)
        
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "RulerItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "RulerItemCell")
        
        addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    // 设置数据
    public func setItems() {
        guard items.count > 0 else {
            return
        }
        
        for i in 0..<items.count {
            let label = UILabel.init(frame: CGRect(x:((self.bounds.width / 2 - kItemWidthHalf) + kItemWidth * CGFloat(i)), y:0, width:kItemWidth, height:10))
            label.textAlignment = NSTextAlignment.center
            label.text = items[i]
            label.textColor = UIColor.gray
            label.font = UIFont.boldSystemFont(ofSize: 12)
            self.collectionView?.addSubview(label)
        }
        
        let lineView = UIView.init(frame: CGRect(x:(self.bounds.width / 2 + kItemWidth * CGFloat(items.count - 1)), y:15, width:1, height:45))
        lineView.backgroundColor = UIColor.cyan
        self.collectionView?.addSubview(lineView)
        
        collectionView?.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:UICollectionViewDelegate,UICollectionViewDataSource

extension CJRulerView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RulerItemCell", for: indexPath)
        
        return cell
    }
}

// MARK:UIScrollViewDelegate

extension CJRulerView {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("scrollViewDidEndDecelerating.x = \(scrollView.contentOffset.x)")
        
        setCollectionViewContentOffset(scrollView: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging = \(scrollView.contentOffset.x)")
        
        setCollectionViewContentOffset(scrollView: scrollView)
    }
    
    func setCollectionViewContentOffset(scrollView:UIScrollView) {
        
        let offsetX:CGFloat = scrollView.contentOffset.x
        
        guard offsetX > 0 else {
            return
        }
        
        guard offsetX <= kItemWidth * CGFloat(items.count) else {
            return
        }
        
        if offsetX < kItemWidthHalf {
            self.collectionView!.setContentOffset(CGPoint(x:0, y:0), animated: true)
            return
        }
        
        let index = Int((offsetX - kItemWidthHalf) / kItemWidth) + 1
        self.collectionView!.setContentOffset(CGPoint(x:Int(CGFloat(index) * kItemWidth),y:0), animated: true)
    }
}


















