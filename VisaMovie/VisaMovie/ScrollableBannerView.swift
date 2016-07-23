//
//  ScrollableBannerView.swift
//
//  Created by jiao qing on 7/4/16.
//

import UIKit

protocol ScrollableBannerViewDelegate : NSObjectProtocol{
    func scrollableBannerView(bannerView : ScrollableBannerView, didTapImage : UIImage)
    func scrollableBannerViewStartScroll(bannerView : ScrollableBannerView)
    
}

class ScrollableBannerView: UIView, UIScrollViewDelegate {
    private var scrollView = UIScrollView()
    private var imageUrls : [String]?
    private var pageControl = UIPageControl()
    weak var delegate : ScrollableBannerViewDelegate?
    
    var timer : NSTimer?
    var pageWidth : CGFloat = 100
    
    override init(frame : CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        addSubview(scrollView)
        
        pageControl.addTarget(self, action: #selector(didClickDot(_:)), forControlEvents: .ValueChanged)
        addSubview(pageControl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageControl.frame = CGRectMake(0, frame.size.height - 30, frame.size.width, 30)
        scrollView.frame = bounds
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, frame.size.height)
    }
    
    func didClickDot(sender : UIPageControl){
        let page = CGFloat(sender.currentPage)
        scrollView.scrollRectToVisible(CGRectMake(page * frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height), animated: true)
    }
    
    func startTimer(){
        timer?.invalidate()
        timer = nil

        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func scrollToNextPage(){
        let totalPage = scrollView.contentSize.width / max(pageWidth, 1)
        let cur = pageControl.currentPage
        if cur == Int(totalPage) - 1{
            scrollView.setContentOffset(CGPointZero, animated: true)
        }else{
            scrollView.setContentOffset(CGPointMake(CGFloat(cur + 1) * pageWidth, 0), animated: true)
        }
    }
    
    func setScrollImages(imageUrls : [String], fill : Bool = true){
        scrollView.removeAllSubViews()
        self.imageUrls = imageUrls
        
        var oX : CGFloat = 0
        for one in imageUrls{
            let btn = UIButton(frame: CGRectMake(oX, 0, frame.size.width, frame.size.height))
          //  btn.addTarget(self, action: #selector(imageViewDidTapped(_:)), forControlEvents: .TouchUpInside)
            btn.backgroundColor = UIColor.whiteColor()
            let imageV = UIImageView(frame: btn.bounds)
            btn.addSubview(imageV)
            btn.clipsToBounds = true
           // btn.property = imageV
            imageV.sd_setImageWithURLStr(one)
            imageV.contentMode = .ScaleAspectFill
            if !fill {
                imageV.contentMode = .ScaleAspectFit
            }
            scrollView.addSubview(btn)
            oX += imageV.frame.size.width
        }
        pageWidth = frame.size.width
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.contentSize = CGSizeMake(frame.size.width * CGFloat(imageUrls.count), frame.size.height)
        
        pageControl.numberOfPages = imageUrls.count
        pageControl.currentPage = 0
        
        if imageUrls.count <= 1{
            pageControl.hidden = true
        }else{
            pageControl.hidden = false
        }
    }
    
//    func imageViewDidTapped(sender : UIButton){
//        if let tmp = sender.property{
//            if let iv = tmp as? UIImageView{
//                if let image = iv.image{
//                    self.delegate?.scrollableBannerView(self, didTapImage: image)
//                }
//            }
//        }
//    }
    
    func scrollViewWillBeginDragging(scrollView : UIScrollView)
    {
        self.delegate?.scrollableBannerViewStartScroll(self)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.frame.size.width <= 0 {
            return
        }
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
