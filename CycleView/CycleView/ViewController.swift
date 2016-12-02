//
//  ViewController.swift
//  CycleView
//
//  Created by WZH on 16/12/2.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

let kScreenW: CGFloat = UIScreen.main.bounds.width
let kScreenH: CGFloat = UIScreen.main.bounds.height

private let kCycleViewH: CGFloat = 150

class ViewController: UIViewController {
    
    
    fileprivate lazy var cycleView: CycelView = {
        
        let cycleView = CycelView.cycleView()
        cycleView.frame = CGRect(x: 0, y: 20, width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cycleView);
        
        cycleView.titles = ["0","1","2","3","4","5","6"]
    }
}

