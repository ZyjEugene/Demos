//
//  CustomCellViewController.swift
//  TableView
//
//  Created by tongqu on 2017/6/22.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

class CustomCellViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- 全局变量
    var logs = [[String]]()
    var tableView: UITableView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
        initTableView()
        
        // Do any additional setup after loading the view.
    }
    
    func initTableView() {
        //creat table
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //creat reusable cell
        self.tableView.register(UINib(nibName: "ImageViewCell", bundle:nil), forCellReuseIdentifier: "SwiftCell")
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView.init()
        
        self.view .addSubview(self.tableView)
    }
    
    func loadData() {
        
        //初始化列表数据
        logs.append(["阳关万里道，不见一人归", "http://pic9.nipic.com/20100902/2029588_234330095230_2.jpg"])
        logs.append(["惟有河边雁，秋来南向飞", "http://pic10.nipic.com/20100929/4879567_114926982000_2.jpg"])
        logs.append(["玉关道路远，金陵信使疏。", "http://pic10.nipic.com/20100929/4879567_114926982000_2.jpg"])
        logs.append(["独下千行泪，开君万里书。", "http://pic9.nipic.com/20100902/2029588_234330095230_2.jpg"])
    }
    
    //MARK:- Delegate And Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identifier: String = "SwiftCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ImageViewCell
        
        cell.textLabel?.numberOfLines = 0
        //获取对应的条目内容
        let entry = logs[indexPath.row]
        
        //单元格标题和内容设置
        cell.titleLabel.text = entry[0]
        cell.loadImage(urlString: entry[1])
        
        return cell
    }
    
    
}
