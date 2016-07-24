//
//  ItemCell.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var photoModel: PhotoBrowser.PhotoModel!{
        didSet{
            dataFill()
        }
    }
    var isHiddenBar: Bool = true{didSet{toggleDisplayBottomBar(isHiddenBar)}}
    
    weak var vc: UIViewController!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageV: ShowImageView!
    
    @IBOutlet weak var bottomContentView: UIView!
    
    @IBOutlet weak var msgTitleLabel: UILabel!
    
    @IBOutlet weak var msgContentTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var imgVHC: NSLayoutConstraint!
    
    @IBOutlet weak var imgVWC: NSLayoutConstraint!
    
    @IBOutlet weak var imgVTMC: NSLayoutConstraint!
    
    @IBOutlet weak var imgVLMC: NSLayoutConstraint!
    
    @IBOutlet weak var asHUD: NVActivityIndicatorView!
    
    var hasHDImage: Bool = false
    
    var isFix: Bool = false
    
    var isDeinit: Bool = false
    
    var isAlive: Bool = true
    
    private var doubleTapGesture: UITapGestureRecognizer!
    private var longPressGesture : UILongPressGestureRecognizer!
    private var singleTapGesture: UITapGestureRecognizer!
    
    lazy var screenH: CGFloat = UIScreen.mainScreen().bounds.size.height
    lazy var screenW: CGFloat = UIScreen.mainScreen().bounds.size.width
    
    deinit{
        self.asHUD?.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ItemCell.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ItemCell.singleTap(_:)))
        singleTapGesture.requireGestureRecognizerToFail(self.doubleTapGesture)
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.numberOfTouchesRequired = 1
        addGestureRecognizer(singleTapGesture)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ItemCell.longPress(_:)))
        longPressGesture.minimumPressDuration = 0.5
        addGestureRecognizer(longPressGesture)
        
        
        scrollView.delegate = self
        
        msgContentTextView.textContainerInset = UIEdgeInsetsZero
        
        //HUD初始化
        asHUD.layer.cornerRadius = 40
        asHUD.type = NVActivityIndicatorType.BallTrianglePath
        
        //更新约束:默认居中
        self.imgVLMC.constant = (self.screenW - 120)/2
        self.imgVTMC.constant = (self.screenH - 120)/2
    }
    
    func doubleTap(tapG: UITapGestureRecognizer){
        //        if !hasHDImage {return}
        //
        let location = tapG.locationInView(tapG.view)
        
        if scrollView.zoomScale <= 1 {
            if !(imageV.convertRect(imageV.bounds, toView: imageV.superview).contains(location)) {return}
            
            let location = tapG.locationInView(tapG.view)
            let rect = CGRectMake(location.x, location.y, 10, 10)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.scrollView.zoomToRect(rect, animated: false)
                var c = (self.screenH - self.imageV.frame.height) / 2
                if c <= 0 {c = 0}
                self.imgVTMC.constant = c
                self.imageV.setNeedsLayout()
                self.imageV.layoutIfNeeded()
            })
            
        }else{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.scrollView.setZoomScale(1, animated: false)
                self.imgVTMC.constant = (self.screenH - self.imageV.showSize.height) / 2
                self.imageV.setNeedsLayout()
                self.imageV.layoutIfNeeded()
            })
        }
    }
    
    func longPress(pG : UILongPressGestureRecognizer){
        if pG.state == .Began {
             NSNotificationCenter.defaultCenter().postNotificationName(CFPBLongPressNofi, object: nil)
        }
    }
    
    func singleTap(tapG: UITapGestureRecognizer){
        if scrollView.zoomScale > 1 {
            doubleTap(doubleTapGesture)
        }else {
            NSNotificationCenter.defaultCenter().postNotificationName(CFPBSingleTapNofi, object: nil)
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageV
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        var c = (self.screenH - self.imageV.frame.height) / 2
        if c <= 0 {c = 0}
        self.imgVTMC.constant = c
    }
    
    func reset(){
        scrollView.setZoomScale(1, animated: false)
        msgContentTextView.setContentOffset(CGPointZero, animated: false)
    }
    
    func dataFill(){
        self.imgVHC.constant = CFPBThumbNailWH
        self.imgVWC.constant = CFPBThumbNailWH
        
        self.imageV.image = nil
        if let cachedImage = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(photoModel.hostHDImgURL){
            self.imageV.image = cachedImage
            self.imageIsLoaded(cachedImage, needAnim: false)
            return
        }
        
        if let url = NSURL(string: photoModel.hostHDImgURL){
            let completeBlock : SDWebImageCompletionBlock = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
                // completion code here
                self.dismissAsHUD(true)
                self.imageIsLoaded(image, needAnim: false)
            }
            self.showAsHUD()
            imageV.sd_setImageWithURL(url, completed: completeBlock)
        }
        
        if photoModel.titleStr != nil {msgTitleLabel.text = photoModel.titleStr}
        if photoModel.descStr != nil {msgContentTextView.text = photoModel.descStr}

        self.reset()
    }
    
    func toggleDisplayBottomBar(isHidden: Bool){
        bottomContentView.hidden = isHidden
    }
    
    /** 图片数据已经装载 */
    func imageIsLoaded(img: UIImage, needAnim: Bool){
        self.scrollView.setZoomScale(1, animated: needAnim)
        //  if !hasHDImage {return}
        
        if vc == nil{return}
        let imgSize = img.size
        var boundsSize = self.bounds.size
        
        //这里有一个奇怪的bug，横屏时，bounds居然是竖屏的bounds
        if vc.view.bounds.size.width > vc.view.bounds.size.height {
            if boundsSize.width < boundsSize.height {
                boundsSize = CGSizeMake(boundsSize.height, boundsSize.width)
            }
        }
        
        let contentSize = boundsSize.sizeMinusExtraWidth
        
        let showSize = CGSize.decisionShowSize(imgSize, contentSize: contentSize)
        imageV.showSize = showSize
        
        self.imgVHC.constant = showSize.height
        self.imgVWC.constant = showSize.width
        self.imgVLMC.constant = 0
        self.imgVTMC.constant = (self.screenH - showSize.height) / 2
        if self.photoModel.isLocal! {return}
        
        if !needAnim{return}
        self.scrollView.contentSize = showSize
    }
    
    
    /** 展示进度HUD */
    func showAsHUD(){
        if asHUD == nil {return}
        
        self.asHUD?.hidden = false
        asHUD?.startAnimation()
        
        UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
            self.asHUD?.alpha = 1
        })
    }
    
    /** 移除 */
    func dismissAsHUD(needAnim: Bool){
        if asHUD == nil {return}
        if needAnim{
            
            UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
                self.asHUD?.alpha = 0
            }) { (complete) -> Void in
                self.asHUD?.hidden = true
                self.asHUD?.stopAnimation()
            }
            
        }else{
            
            self.asHUD?.alpha = 0
            self.asHUD?.hidden = true
            self.asHUD?.stopAnimation()
        }
    }
    
    
}