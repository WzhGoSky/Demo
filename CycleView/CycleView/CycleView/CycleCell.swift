//
//  CycleCell.swift
//  CycleView
//
//  Created by WZH on 16/12/2.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class CycleCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    var num: String?{
        
        didSet{
            
            guard let num = num else {
                
                return
            }
            
            title.text = num
        }
    }
}
