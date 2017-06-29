//
//  SimpleViewController.swift
//  TableView
//
//  Created by tongqu on 2017/6/20.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

let cellIndentifier = "cellIdentifier"


class SimpleViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    //MARK:- 声明全局变量
    var sysFontNames :NSMutableArray?
    var poemLabel :UILabel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sysFontNames = getFontNames()
        
        initView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- 初始化View
    func initView() {
        getPoemLabel()
        getTableView()
    }
    
    //MARK:- 创建标签
    func getPoemLabel() {
        
        let poem = "将进酒·君不见【作者】李白 【朝代】唐  君不见， 黄河之水天上来， 奔流到海不复回。君不见， 高堂明镜悲白发， 朝如青丝暮成雪。人生得意须尽欢， 莫使金樽空对月。天生我材必有用， 千金散尽还复来。烹羊宰牛且为乐， 会须一饮三百杯。岑夫子， 丹丘生， 将进酒， 杯莫停。与君歌一曲， 请君为我倾耳听。钟鼓馔玉不足贵， 但愿长醉不复醒。古来圣贤皆寂寞， 惟有饮者留其名。陈王昔时宴平乐， 斗酒十千恣欢谑。主人何为言少钱， 径须沽取对君酌。五花马， 千金裘， 呼儿将出换美酒， 与尔同销万古愁。"
        let lable :UILabel = UILabel(frame: CGRect(origin:CGPoint(x:20,y:60),size:CGSize(width:UIScreen.main.bounds.width-40,height: 260)))
        lable.backgroundColor = UIColor.white
        lable.text = poem
        lable.textColor = UIColor.red
        lable.numberOfLines = 0
        self.view.addSubview(lable)
        self.poemLabel = lable
    }
    
    //MARK:- 创建表
    func getTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 320, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-300))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView.init()
        self.view.addSubview(tableView)
    }
    
    //MARK:- 获取系统字体
    func getFontNames() -> NSMutableArray {
        let fonts = NSMutableArray()
        for family in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: family) {
                fonts.add(font);
            }
        }
        return fonts;
    }
    
    //MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sysFontNames!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIndentifier)
        }
        
        cell?.textLabel?.text = self.sysFontNames?[indexPath.row] as? String
        //cell?.selectionStyle = .none
        
        return cell!
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.poemLabel?.font = UIFont(name: self.sysFontNames?[indexPath.row] as! String, size: 16)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 1)!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("index.row = editingStyle第\(indexPath.row)行")
    }
    
}
