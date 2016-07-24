//
//  PhotoBrowser.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowser: UIView {
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: Layout())
    var showType: PhotoBrowser.ShowType = PhotoBrowser.ShowType.ZoomAndDismissWithSingleTap
    
    let displayView = DisplayView()
    var photoModels : [PhotoModel]!
    var hideMsgForZoomAndDismissWithSingleTap: Bool = false
    
    let asHUD = NVActivityIndicatorView(frame: CGRectMake(0, 0, 80, 80))
    
    private weak var dismissTarget : AnyObject?
    private var dismissSelector : Selector?
    
    lazy var pagecontrol = UIPageControl()
    var page: Int = 0 {
        didSet{
            pageControlPageChanged(page)
        }
    }
    
    weak var vc: UIViewController!
    
    let propImgV = UIImageView()
    
    var isNavBarHidden: Bool!
    var isTabBarHidden: Bool!
    var isStatusBarHidden: Bool!
    
    var showIndex: Int = 0
    
    var dismissBtn,saveBtn: UIButton!
    var isHiddenBar: Bool = false
    
    deinit{NSNotificationCenter.defaultCenter().removeObserver(self);print("deinit")}
    
    lazy var hud: UILabel = {
        let hud = UILabel()
        hud.backgroundColor = UIColor.defaultBlack()
        hud.textColor = UIColor.whiteColor()
        hud.alpha = 0
        hud.textAlignment = NSTextAlignment.Center
        hud.layer.cornerRadius = 5
        hud.layer.masksToBounds = true
        return hud
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hideMsgForZoomAndDismissWithSingleTap = true
        
        propImgV.contentMode = UIViewContentMode.ScaleAspectFit
        propImgV.clipsToBounds = true
        
        asHUD.layer.cornerRadius = 40
        asHUD.type = NVActivityIndicatorType.BallTrianglePath
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PhotoBrowser.singleTapAction), name: CFPBSingleTapNofi, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PhotoBrowser.saveAction), name: CFPBLongPressNofi, object: nil)
        
        collectionViewPrepare()
        
        backgroundColor = UIColor.defaultBlack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetDimissSelector(target : AnyObject, sel : Selector){
        dismissTarget = target
        dismissSelector = sel
    }
    
    func showPhotoBrowser(fromViewController : UIViewController, imageUrls : [String], index : Int) {
        if imageUrls.count == 0{
            return
        }
        
        var cindex = min(index, imageUrls.count - 1)
        cindex = max(0, index)
        
        displayView.imgsPrepare(imageUrls, isLocal: false)
        
        let wh = min(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        displayView.make_center(offsest: CGPointZero, width: wh, height: wh)
        
        var models: [PhotoBrowser.PhotoModel] = []
        let cnt = imageUrls.count - 1
        for i in 0...cnt {
            let model = PhotoBrowser.PhotoModel(hostHDImgURL: imageUrls[i], sourceView: displayView.subviews[i])
            models.append(model)
        }
        
        self.photoModels = models
        self.show(inVC:fromViewController, index: cindex)
    }
    
    func show(inVC vc: UIViewController,index: Int){
        assert(index <= photoModels.count - 1, "Error: Index is Out of DataModels' Boundary!")
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: CFPBShowKey)
        isStatusBarHidden = UIApplication.sharedApplication().statusBarHidden
        
        UIApplication.sharedApplication().statusBarHidden = true
        showIndex = index
        
        //记录
        self.vc = vc
        vc.view.addSubview(self)
        
        let navVC = vc.navigationController
        
        if vc.navigationController != nil { isNavBarHidden = vc.navigationController?.navigationBarHidden}
        if vc.tabBarController != nil { isTabBarHidden = vc.tabBarController?.tabBar.hidden}
        
        navVC?.navigationBarHidden = true
        vc.tabBarController?.tabBar.hidden = true
        
        self.collectionView.reloadData()
        self.collectionView.setContentOffset(CGPointMake((self.frame.size.width + 20) * CGFloat(self.showIndex), 0), animated: false)
        
        zoomInWithAnim(index)
        pagecontrolPrepare()
        pagecontrol.currentPage = index
        
        NSNotificationCenter.defaultCenter().postNotificationName(PhotoBrowserDidShowNoti, object: self)
    }
}

extension PhotoBrowser: UIActionSheetDelegate{
    func zoomInWithAnim(page: Int){
        let photoModel = photoModels[page]
        
        propImgV.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, 302.5)
        vc.view.addSubview(propImgV)
        
        if let cachedImage = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(photoModel.hostHDImgURL){
            propImgV.image = cachedImage
            self.handleShowAnim(propImgV, thumbNailSize: nil)
            return
        }
        
        if let url = NSURL(string: photoModel.hostHDImgURL){
            let completeBlock : SDWebImageCompletionBlock = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
                self.handleShowAnim(self.propImgV, thumbNailSize: nil)
                self.dismissAsHUD()
            }
            showAsHUD()
            propImgV.sd_setImageWithURL(url, completed: completeBlock)
        }
    }
    
    func handleShowAnim(propImgV: UIImageView,thumbNailSize: CGSize?){
        let showSize = thumbNailSize ?? CGSize.decisionShowSize(propImgV.image!.size, contentSize: vc.view.bounds.size)
        self.collectionView.alpha = 0
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
            propImgV.bounds = CGRectMake(0, 0, showSize.width, showSize.height)
            propImgV.center = self.vc.view.center
            }, completion: {(Bool) -> Void in
                self.collectionView.alpha = 1
                self.propImgV.removeFromSuperview()
        })
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.tag == 2 {
            if buttonIndex == 1 {
                let itemCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
                if itemCell.imageV.image == nil {
                    showHUD("Failed", autoDismiss: 2);
                    return
                }
                showHUD("Saved", autoDismiss: 1)
                UIImageWriteToSavedPhotosAlbum(itemCell.imageV.image!, nil, nil, nil)
            }
        }
    }
    
    func saveAction(){
        let popup = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Save Image")
        popup.tag = 2
        popup.showInView(self)
    }
    
    /**  单击事件  */
    func singleTapAction(){
        if showType != PhotoBrowser.ShowType.ZoomAndDismissWithSingleTap {
            isHiddenBar = !isHiddenBar
            
            dismissBtn.hidden = isHiddenBar
            saveBtn.hidden = isHiddenBar
            
            let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
            cell.toggleDisplayBottomBar(isHiddenBar)
        }else{
            dismissPrepare()
        }
    }
    
    func dismissAction(isZoomType: Bool){
        UIApplication.sharedApplication().statusBarHidden = isStatusBarHidden
        
        if vc.navigationController != nil {vc.navigationController?.navigationBarHidden = isNavBarHidden}
        if vc.tabBarController != nil {vc.tabBarController?.tabBar.hidden = isTabBarHidden}
        
        scrollToNewPage()
        zoomOutWithAnim(page)
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: CFPBShowKey)
        NSNotificationCenter.defaultCenter().postNotificationName(PhotoBrowserDidDismissNoti, object: self)
    }
    
    func showAsHUD(){
        asHUD.center = center
        asHUD.startAnimation()
        addSubview(asHUD)
    }
    
    /** 移除 */
    func dismissAsHUD(){
        asHUD.removeFromSuperview()
        asHUD.stopAnimation()
    }
    
    /** 关闭动画 */
    func zoomOutWithAnim(page: Int){
        let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
        let cellImageView = cell.imageV
        
        propImgV.image = cellImageView.image
        vc.view.addSubview(propImgV)
        collectionView.alpha = 0
        
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
            self.propImgV.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 302.5)
            self.alpha = 0
        }) { (complete) -> Void in
            self.propImgV.removeFromSuperview()
            self.removeFromSuperview()
            self.alpha = 1
            self.collectionView.alpha = 1
        }
    }
    
    func scrollToNewPage() {
        if dismissTarget != nil && dismissSelector != nil{
            if dismissTarget!.respondsToSelector(dismissSelector!){
                dismissTarget!.performSelector(dismissSelector!, withObject: NSNumber(integer : pagecontrol.currentPage))
            }
        }
    }
}

extension PhotoBrowser: UICollectionViewDataSource,UICollectionViewDelegate{
    var cellID: String {return "ItemCell"}
    
    func dismissPrepare(){
        dismissAction(true)
    }
    
    
    func collectionViewPrepare(){
        self.addSubview(collectionView)
        collectionView.make_4Inset(UIEdgeInsetsMake(0, 0, 0, -CFPBExtraWidth))
        collectionView.registerNib(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.defaultBlack()
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! ItemCell
        itemCell.isHiddenBar = isHiddenBar
        itemCell.vc = vc
        
        let photoModel = photoModels[indexPath.row]
        photoModel.modelCell = itemCell
        itemCell.photoModel = photoModel
        itemCell.toggleDisplayBottomBar(true)
        
        return itemCell
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let itemCell = cell as! ItemCell
        itemCell.reset()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.bounds.size.width == 0 {
            return
        }
        let nPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
        if nPage != page{
            page = nPage
            scrollToNewPage()
        }
        
    }
}
