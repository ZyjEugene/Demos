//
//  TQSideMenu.swift
//  TableView
//
//  Created by tongqu on 2017/6/28.
//  Copyright © 2017年 Eugene Space. All rights reserved.
//

import UIKit

enum TQSlideMenuTitleStyle {
    case normal             //默认
    case gradient           //颜色渐变
    case transfrom          //放大
}
enum TQSiduMenuIndicatorStyle {
    case normal       //常规
    case followText    //跟随文本长度
    case stretch      //拉伸
}


class TQScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//swift3 中新增加了访问控制权限fileprivate. fileprivate:元素的访问权限为文件内私有,现在的private则是真正的私有，离开了这个类或者结构体的作用域外面就无法访问。
//伸缩动画的偏移量 (为了让下滑线的宽度“伸缩动画”和“跟随文本长度”作区分，可要可不要)
fileprivate let indicatorAnimatePadding:CGFloat = 6.0

class TQSideMenu: UIView {
    
    //MARK: - property
    /**属性的监视器 {willSet{} didSet{}}
     作用：用来监控属性值的变化,每次属性被修改的时候都会被调用,即使新的值和旧的值一样.
     描述：一个属性监视器由 willSet 和 didSet 组成, willSet 在设置新的值之前被调用,新的值作为传参,didSet 在新的值被设置之后调用,会将旧的属性值作为传参.
     */
    // 选中颜色
    var selectedColor:UIColor = UIColor.red  {
        didSet{
            updateTabCololr()
        }
    }
    // 未选中颜色
    var unSelectedColor:UIColor = UIColor.black {
        didSet{
            updateTabCololr()
        }
    }
    
    // 下标宽度
    var indicatorWidth:CGFloat = 30 {
        didSet {
            setupIndicatorView()
        }
    }
    // 下标高度
    var indicatorHeight:CGFloat = 2 {
        didSet{
            setupIndicatorView()
        }
    }
    // 下标距离底部距离
    var bottomPadding:CGFloat = 2 {
        didSet{
            setupIndicatorView()
        }
    }
    
    
    // 标题字体
    var font:UIFont = UIFont.systemFont(ofSize: 13) {
        didSet{
            updateFonts()
        }
    }
    
    // 指示线的类型
    var titleStyle:TQSlideMenuTitleStyle = .normal
    var indicatorStyle:TQSiduMenuIndicatorStyle = .normal

    //MARK: - 全局变量
    fileprivate var headerScrollView:TQScrollView = TQScrollView()
    fileprivate var bodyScrollView:TQScrollView = TQScrollView()
    fileprivate var indicatorView:UIView = UIView()
    fileprivate var bottomLine:UIView = UIView()
    
    fileprivate var leftIndex:Int = 0
    fileprivate var rightIndex:Int = 0
    fileprivate var selectedIndex:Int = 0
    fileprivate var itemLabels:Array<UILabel>  = []
    
    
    //MARK: header tab margin
    private var itemMargin: CGFloat = 15.0
    private var titleAry: Array<String>
    private var controllers: Array<UIViewController>
    
    //MARK: - life cycle
    init(frame: CGRect, titles:Array<String>,
         childControllers:Array<UIViewController>) {
        
        titleAry = titles
        controllers = childControllers
        
        super.init(frame: frame)
        
        bottomLine.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.addSubview(bottomLine)
        
        //top tab bar
        setupHeaderScrollView()
        setupIndicatorView()
        
        //body scroll view
        print("init---")

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layout--")
        headerScrollView.frame = self.bounds
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 0.5,
                                  width: self.frame.width, height: 0.5)
        if bodyScrollView.superview == nil {
            self.superview?.addSubview(bodyScrollView)
            setupBodyScrollView()
        }
    }
    
    //MARK: - private method
    //MARK: 标签栏
    private func setupHeaderScrollView() {
 
        var originX = itemMargin
        for (index, title) in titleAry.enumerated() {
            let itemLabel = UILabel()
            itemLabel.isUserInteractionEnabled = true
            //计算title长度 "as":消除二义性，进行类型转换
            let size = title.size(attributes: [NSFontAttributeName : font])
            itemLabel.frame = CGRect(x: originX, y: 0, width: size.width, height: self.frame.height)
            
            itemLabel.text = title
            itemLabel.font = font
            itemLabel.textColor = index == selectedIndex ? selectedColor : unSelectedColor
            itemLabel.transform = index == selectedIndex ? CGAffineTransform.init(scaleX: 1.1, y: 1.1) : CGAffineTransform.identity
            itemLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClicked(gesture:))))
            itemLabels.append(itemLabel)
            headerScrollView.addSubview(itemLabel)
            originX = itemLabel.frame.maxX + itemMargin
        }
        
        headerScrollView.backgroundColor = UIColor.clear
        headerScrollView.contentSize = CGSize(width: originX, height: self.frame.height)
        
        self.addSubview(headerScrollView)
        headerScrollView.addSubview(indicatorView)
        
        if headerScrollView.contentSize.width < self.frame.width {
            //item长度小于width，重新计算margin排版
            updateItemLabelsFrame()
        }
        
    }
    
    //点击事件更新界面
    private func updateTitleItem(from:Int, to:Int) {
        
        itemLabels[from].textColor = unSelectedColor
        itemLabels[to].textColor = selectedColor
        
        UIView.animate(withDuration: 0.1) {
            self.itemLabels[to].transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            self.itemLabels[from].transform = .identity
        }
    }
    
    //修正标签在headerScrollView中的位置
    fileprivate func updateHeaderScrollViewContent() {
        
        let selectedItem = itemLabels[selectedIndex]
        let tabBarWidth = headerScrollView.frame.width;
        var reviseX:CGFloat = 0
        
        if selectedItem.center.x + tabBarWidth/2 >= headerScrollView.contentSize.width {
            
            reviseX = headerScrollView.contentSize.width - tabBarWidth
        } else if selectedItem.center.x - tabBarWidth/2 <= 0{
            reviseX = 0
        } else {
            reviseX = selectedItem.center.x - tabBarWidth/2
        }
        
        headerScrollView.setContentOffset(CGPoint(x:reviseX, y:0), animated: true)
    }

    //更新itemLabel在Content上的布局
    private func updateItemLabelsFrame() {
        let newMargin = itemMargin
            + (self.frame.width - headerScrollView.contentSize.width)
            / CGFloat(self.itemLabels.count*2)
        var originX = newMargin
        for itemLabel in itemLabels {
            var frame = itemLabel.frame
            frame.size.height = self.frame.height
            frame.origin.x = originX
            itemLabel.frame = frame
            originX = frame.maxX + newMargin
        }
        headerScrollView.contentSize = CGSize(width: originX, height: frame.height)
        
    }
    
    //MARK: 配置标签下滑动指示
    private func setupIndicatorView() {
        
        var frame = itemLabels[selectedIndex].frame
        frame.origin.y = self.frame.height - bottomPadding - indicatorHeight
        frame.size.height = indicatorHeight
        
        if indicatorStyle == .normal {
            frame.origin.x = frame.midX - indicatorWidth/2
            frame.size.width = indicatorWidth
        }
        
        indicatorView.frame = frame
        indicatorView.backgroundColor = selectedColor
    }
    
    //更新滑动指示标签
    private func updateIndicatorView(from:Int, to:Int) {
        let fromLabel = itemLabels[from]
        let toLabel = itemLabels[to]
        
        if indicatorStyle == .normal {
            UIView.animate(withDuration: 0.3, animations: { 
                self.indicatorView.center = CGPoint(x: toLabel.center.x,  
                                                    y: self.indicatorView.center.y)
            })
        } else if indicatorStyle == .followText {

            UIView.animate(withDuration: 0.3, animations: {
                let width = toLabel.frame.size.width
                self.indicatorView.frame.size.width = width
                self.indicatorView.center = CGPoint(x: toLabel.center.x,
                                                    y: self.indicatorView.center.y)
            })
        } else {
            /**下滑线拉伸动画过程分析：
             1、当前显示文本的width（拉伸前）
             2、需要下划线拉伸的最大值（拉伸过程） 
             3、最后要显示的下划线width跟选中的文本width相同（拉伸结束）
            */
            
            var frame = indicatorView.frame
            frame.size.width = itemLabels[to].frame.width
            //最终显示的指示下划线长度和文本的width相同
            let finnalFrame = frame
            
            //让下滑线做拉伸动画，前提是要先获取需要拉伸的最大值
            let max = fromLabel.frame.width + toLabel.frame.width + itemMargin*2
            
            frame.size.width = max - indicatorAnimatePadding*2
            //拉伸到最大值时下划线的centerX
            let x = (toLabel.frame.maxX - fromLabel.frame.minX)/2 + fromLabel.frame.minX
            
            /**关键帧动画
             *  withDuration:  动画持续时间
             *  delay: 延迟时间
             *  options：动画选项
             */
            UIView.animateKeyframes(withDuration: 0.3, delay: 0,
                                    options: .calculationModePaced,
                                    animations: { 
                                        
                                        /**
                                         *  withRelativeStartTime  相对开始时间
                                         *  relativeDuration 相对时间(动画所持续的时间)
                                         */
                                        // 第一个关键帧
                                         UIView.addKeyframe(withRelativeStartTime: 0.0,// 相对于0.3秒所开始的时间（第0秒开始动画）
                                                           relativeDuration: 0.15,// 相对于0.3秒动画的持续时间（动画持续0.15秒）
                                                           animations: { 
                                                            self.indicatorView.frame = frame
                                                            self.indicatorView.center = CGPoint(x: x, y: self.indicatorView.center.y)
                                        })
                                        // 第二个关键帧
                                        UIView.addKeyframe(withRelativeStartTime: 0.15,// 相对于0.3秒所开始的时间（第0.15秒开始动画）
                                                           relativeDuration: 0.15,// 相对于0.3秒动画的持续时间（动画持续0.15秒）
                                                           animations: { 
                                                            self.indicatorView.frame = finnalFrame
                                                            self.indicatorView.center = CGPoint(x: toLabel.center.x, y: self.indicatorView.center.y)
                                        })
            },completion: nil)
            
        }
        
        
        
    }
    
    //渐变颜色
    fileprivate func averageColor(fromColor:UIColor , toColor:UIColor , percent:CGFloat) -> UIColor {
        var fromRed:CGFloat = 0.0
        var fromGreen:CGFloat = 0.0
        var fromBlue:CGFloat = 0.0
        var fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed:CGFloat = 0.0
        var toGreen:CGFloat = 0.0
        var toBlue:CGFloat = 0.0
        var toAlpha:CGFloat = 0.0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        let nowRed = fromRed + (toRed - fromRed)*percent
        let nowGreen = fromGreen + (toGreen - fromGreen)*percent
        let nowBlue = fromBlue + (toBlue - fromBlue)*percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha)*percent
        
        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }

    //MARK: 控制器 ScrollView
    private func setupBodyScrollView() {
        bodyScrollView.isPagingEnabled = true
        bodyScrollView.bounces = false
        bodyScrollView.delegate = self
        if let frame = self.superview?.frame {
            bodyScrollView.frame = CGRect(x: 0, y: self.frame.maxY,
                                          width: frame.width,
                                          height: frame.height - self.frame.maxY)
            //enumerated()数组枚举遍历，（index,let）
            for (index, vc) in controllers.enumerated() {
                vc.view.frame = bodyScrollView.bounds
                vc.view.center = CGPoint(x: bodyScrollView.frame.width*(CGFloat(index)+0.5),
                                         y: bodyScrollView.frame.height/2)
                bodyScrollView.addSubview(vc.view)
            }
            bodyScrollView.contentSize = CGSize(
                width: bodyScrollView.frame.width * CGFloat(controllers.count),
                height: bodyScrollView.frame.height)
        }
    }
    
    //MARK: 属性监视器 跟OC中的set 方法很像
    private func updateTabCololr() {
        for itemLabel in itemLabels {
            itemLabel.textColor = unSelectedColor
        }
        itemLabels[selectedIndex].textColor = selectedColor
        indicatorView.backgroundColor = selectedColor
    }
    
    private func updateFonts() {
        var originX = itemMargin
        for itemLabel in itemLabels {
            let size = (itemLabel.text! as NSString).size(attributes: [NSFontAttributeName:font])
            itemLabel.frame = CGRect(x: originX, y: 0, width: size.width, height: self.frame.height)
            itemLabel.font = font
            originX = itemLabel.frame.maxX + itemMargin
        }
        
        headerScrollView.contentSize = CGSize(width: originX, height: self.frame.height)
        
        if headerScrollView.contentSize.width < self.frame.width {
            //item长度小于width，重新计算margin排版
            updateItemLabelsFrame()
        }
        
        //更新字体后要同时要重新设置indicator view
        setupIndicatorView()
    }
    
    
    //MARK: - action
    // tab bar点击事件
    @objc private func itemClicked(gesture: UITapGestureRecognizer) {
        
        let item = gesture.view as! UILabel
        
        //判断点击的表现是否是已经选中过的标签
        if item == itemLabels[selectedIndex] {
            return
        }
        
        //根据手势获取标签在标签数组中的下标
        let fromIndex = selectedIndex
        selectedIndex = itemLabels.index(of: item)!
        
        //更新标签栏的状态
        updateTitleItem(from: fromIndex, to: selectedIndex)
        
        //设置滑动的下标
        updateIndicatorView(from: fromIndex, to: selectedIndex)
        
        //更新body scroll view
        bodyScrollView.setContentOffset(CGPoint(x: bodyScrollView.frame.width*CGFloat(selectedIndex), y: 0), animated: false)
        
        if headerScrollView.contentSize.width >= self.frame.width {
            updateHeaderScrollViewContent()
        }
        
        //print(" index \(selectedIndex)  already clicked !" + String(describing: item.text))
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 代理
extension TQSideMenu: UIScrollViewDelegate {
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bodyScrollView {
            let offset = scrollView.contentOffset
            print("offset:\(offset)")
            if offset.x <= 0 {
                //左边界
                leftIndex = 0
                rightIndex = leftIndex
            } else if (offset.x >= (scrollView.contentSize.width - scrollView.frame.width)) {
                //右边界
                leftIndex = itemLabels.count - 1
                rightIndex = leftIndex
            } else {
                leftIndex = Int(offset.x/scrollView.frame.width)
                rightIndex = leftIndex + 1
            }
            
            //计算偏移的相对位移
            let relativeLocation = bodyScrollView.contentOffset.x/bodyScrollView.frame.width - CGFloat(leftIndex)
            if relativeLocation == 0 {
                return
            }
            
            //更新 top bar
            updateTitleStyle(relativeLocation)
            updateIndicatorStyle(relativeLocation)
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bodyScrollView {
            selectedIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            updateHeaderScrollViewContent()
        }
    }
    
    //private method
    func updateTitleStyle(_ relativeLacation:CGFloat) {
        let leftItem = itemLabels[leftIndex]
        let rightItem = itemLabels[rightIndex]
        switch titleStyle {
        case .gradient:
            leftItem.textColor = self.averageColor(fromColor: selectedColor, toColor: unSelectedColor, percent: relativeLacation)
            rightItem.textColor = self.averageColor(fromColor: unSelectedColor, toColor: selectedColor, percent: relativeLacation)
            
        case .normal:
            leftItem.textColor = relativeLacation <= 0.5 ? selectedColor : unSelectedColor
            rightItem.textColor = relativeLacation <= 0.5 ? unSelectedColor : selectedColor
            
        default:
            
            if relativeLacation <= 0.5 {
                
                leftItem.textColor = selectedColor
                leftItem.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
                
                rightItem.textColor = unSelectedColor
                rightItem.transform = CGAffineTransform.identity
            }
            else {
                leftItem.textColor = unSelectedColor
                leftItem.transform = CGAffineTransform.identity
                
                rightItem.textColor = selectedColor
                rightItem.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
            }
            break
        }

    }
    
    func updateIndicatorStyle(_ relativeLacation:CGFloat) {
        
        let leftItem = itemLabels[leftIndex]
        let rightItem = itemLabels[rightIndex]
        
        if indicatorStyle == .normal {
            //常规模式 只需更新中心点即可
            let max = rightItem.center.x - leftItem.center.x
            self.indicatorView.center = CGPoint(x:leftItem.center.x + max*relativeLacation,
                                                y:indicatorView.center.y)
        } else {
            //仔细观察位移效果，分析出如下计算公式
            let distance = indicatorStyle == .followText ? 0 : indicatorAnimatePadding
            var frame = self.indicatorView.frame
            let maxWidth = rightItem.frame.maxX - leftItem.frame.minX - distance*2
            if relativeLacation <= 0.5 {
                frame.size.width = leftItem.frame.width + (maxWidth - leftItem.frame.width)*(relativeLacation/0.5)
                frame.origin.x = leftItem.frame.minX + distance*(relativeLacation/0.5)
            }
            else{
                frame.size.width = rightItem.frame.width + (maxWidth - rightItem.frame.width)*((1-relativeLacation)/0.5)
                frame.origin.x = rightItem.frame.maxX - frame.size.width - distance*((1-relativeLacation)/0.5)
            }
            self.indicatorView.frame = frame
        }

       }
   
    
}
