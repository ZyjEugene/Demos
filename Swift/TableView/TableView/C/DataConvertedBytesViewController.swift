//
//  DataConvertedBytesViewController.swift
//  TableView
//
//  Created by Eugene on 2017/7/20.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

class DataConvertedBytesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 有时上传或者发送图片、文字时，需要将数据转换为 bytes 字节数组。
        self.dataConvertedBytes()
        
        // Do any additional setup after loading the view.
    }
    
    func dataConvertedBytes() {
        
        //MARK: - 将 Data 转换为 [UInt8] 的两种方法
        let data = "Eugene love Swift".data(using: .utf8)!

        // 方法一: 使用[UInt8]构造函数
        let bytes1 = [UInt8](data)
        print(bytes1)
        
        // 方法二: 通过pointer指针获得
        let bytes2 = data.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: data.count))
        }
        
        print(bytes2)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
