//
//  AdaptionCellViewController.swift
//  TableView
//
//  Created by tongqu on 2017/6/20.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

class AdaptionCellViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    //MARK:- 全局变量
    var logs = [String]()
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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView.init()
        
        self.view .addSubview(self.tableView)
    }
    
    func loadData() {
        
        logs = ["Do any additional setup after loading the view.",
                "伤高怀远几时穷？无物似情浓。离愁正引千丝乱，更东陌、飞絮蒙蒙。嘶骑渐遥，征尘不断，何处认郎踪",
                "双鸳池沼水溶溶，南北小桡通。梯横画阁黄昏后，又还是、斜月帘栊。沉恨细思，不如桃杏，犹解嫁东风。",
                "碧云天，黄叶地。秋色连波，波上寒烟翠。山映斜阳天接水。芳草无情，更在斜阳外。",
                "黯乡魂，追旅思。夜夜除非，好梦留人睡。明月楼高休独倚。酒入愁肠，化作相思泪。",
                "新月曲如眉，未有团圞意。红豆不堪看，满眼相思泪。",
                "终日劈桃穰，人在心儿里。两朵隔墙花，早晚成连理。"];
        logs.insert("阳关万里道，不见一人归", at: logs.endIndex)
        logs.append("惟有河边雁，秋来南向飞")
        logs = logs + ["玉关道路远，金陵信使疏。",
                       "独下千行泪，开君万里书。"]
    }
  
    //MARK:- Delegate And Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identifier: String = "SwiftCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.numberOfLines = 0;
        //cell.textLabel?.text = logs[indexPath.row]
        cell.textLabel?.attributedText = getAttributeString(title: "古诗词句\(indexPath.row)", subTitle: logs[indexPath.row])
        
        return cell
    }
    
    func getAttributeString(title: String, subTitle: String) -> NSAttributedString {
        //标题字体样式
        let titleFont = UIFont.preferredFont(forTextStyle: .headline)
        let titleColor = UIColor(red: 0/255.0, green: 192/255.0, blue: 255/255.0, alpha: 1.0)
        let titleAttributes = [NSFontAttributeName: titleFont,
                               NSForegroundColorAttributeName: titleColor] as [String : Any]
        
        //简介字体样式
        let subTitleFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        let subTitleAttribute = [NSFontAttributeName: subTitleFont]
        
        //拼接并获取最终文本
        let titleString = NSMutableAttributedString(string: "\(title)\n",attributes: titleAttributes)
        let subTitleString = NSAttributedString(string: subTitle, attributes: subTitleAttribute)
        
        titleString.append(subTitleString)
        return titleString
   
    }
    
    
    
    
    
    
}
