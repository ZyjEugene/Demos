//
//  ImageViewCell.swift
//  TableView
//
//  Created by tongqu on 2017/6/22.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

class ImageViewCell: UITableViewCell {
    
    //标题文本标签
    @IBOutlet weak var titleLabel: UILabel!
    
    //内容图片
    @IBOutlet weak var contentImageView: UIImageView!
    
    //内容图片的宽高比约束  
    //willSet 和 didSet: willSet 和 didSet的作用是对赋值过程前后附加额外的操作 可以看做是捕获状态然后做操作,在将要赋值的时候和已经赋值的时候做相 关操作
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            
            if oldValue != nil {
                contentImageView.removeConstraint(oldValue!)
            }
            
            if aspectConstraint != nil {
                contentImageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //清除内容图片的宽高比约束
        aspectConstraint = nil
    }
    
    
    //加载内容图片（并设置高度约束）
    func loadImage(urlString: String) {
        //定义NSURL对象
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!)
        //从网络获取数据流,再通过数据流初始化图片
        if let imageData = data, let image = UIImage(data: imageData) {
            //计算原始图片的宽高比
            let aspect = image.size.width / image.size.height
            //设置imageView宽高比约束
            aspectConstraint = NSLayoutConstraint(item: contentImageView,
                                                  attribute: .width, relatedBy: .equal,
                                                  toItem: contentImageView, attribute: .height,
                                                  multiplier: aspect, constant: 0.0)
            //加载图片
            contentImageView.image = image
        }else{
            //去除imageView里的图片和宽高比约束
            aspectConstraint = nil
            contentImageView.image = nil
        }
    }
  
}
