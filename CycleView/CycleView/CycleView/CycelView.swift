//
//  CycelView.swift
//  CycleView
//
//  Created by WZH on 16/12/2.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

private let kCellID = "CycleCell"

class CycelView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 定时器
    var timer: Timer?
    
    var titles: [String]?{
        
        didSet{
            
            //刷新布局
            collectionView.reloadData()
            
            //2.设置pagecontrol个数
            pageControl.numberOfPages = titles?.count ?? 0
            
            //3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (titles?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeTimer()
            
            addCycleTimer()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
        
    }
    
    //设置尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //获取layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
    
    
}

//MARK:- 创建循环滚动图
extension CycelView{
    
    class func cycleView() -> CycelView{
        
        return Bundle.main.loadNibNamed("CycelView", owner: nil, options: nil)?.first as! CycelView
    }
}

//MARK:- 遵守协议UICollectionViewDataSource
extension CycelView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (titles?.count ?? 0)*500
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! CycleCell
        
        let index = indexPath.item % titles!.count
        
        cell.num = titles?[index]
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
        
    }
    
}

extension CycelView: UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //获取滚动的偏移量
        let offsetx = scrollView.contentOffset.x
        
        //2.计算pageControl的currentindex
        pageControl.currentPage = Int(offsetx / scrollView.bounds.width + 0.5) % (titles?.count ?? 1)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        
        addCycleTimer()
    }
}

//MARK:- 对定时器的操作方法
extension CycelView{
    
    ///创建定时器的方法
    fileprivate func addCycleTimer(){
        
        timer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }

    fileprivate func removeTimer(){
        
        timer?.invalidate() //从运行循环中移除
        timer = nil
    }
    
    @objc private func scrollToNext(){
        
        //1.获取当前的滚动
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}
