//
//  ViewExtensions.swift
//
//

import UIKit

let borderConstraintGroup = ConstraintGroup()

extension UIImageView {
    func sd_setImageWithURLStr(str : String?){
        if let imageUrl = str{
            if let url = NSURL(string:  imageUrl){
                self.sd_setImageWithURL(url)
            }
        }
    }
}

extension UIView {
    func addSubviews(views : UIView...) {
        for v in views {
            self.addSubview(v)
        }
    }
    
    class func setFrameToViews(frame: CGRect, views : UIView...) {
        for v in views {
            v.frame = frame
        }
    }
    
    func removeAllSubViews() {
        let subViews = self.subviews
        for v in subViews {
            v.removeFromSuperview()
        }
    }
    
    func withBackgroundColor(color : UIColor) -> UIView {
        backgroundColor = color
        return self
    }
    
    func hideViews(views : UIView...) {
        views.forEach { (view) -> () in
            view.hidden = true
        }
    }
    
    func showViews(views : UIView...) {
        views.forEach { (view) -> () in
            view.hidden = false
        }
    }
    
}

extension UILabel {
    func withFontHeletica(size : CGFloat) -> UILabel{
        self.font = DJFont.helveticaFontOfSize(size)
        return self
    }
    
    func withFontHeleticaMedium(size : CGFloat) -> UILabel{
        self.font = DJFont.mediumHelveticaFontOfSize(size)
        return self
    }
    
    func withFontHeleticaBold(size : CGFloat) -> UILabel{
        self.font = DJFont.boldHelveticaFontOfSize(size)
        return self
    }
    
    func withFontHeleticaLight(size : CGFloat) -> UILabel{
        self.font = DJFont.lightHelveticaFontOfSize(size)
        return self
    }
    
    func textCentered() -> UILabel {
        self.textAlignment = NSTextAlignment.Center
        return self
    }
    
    func withTextColor(color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    func withText(text: String?) -> UILabel {
        self.text = text
        return self
    }
}

extension UIButton {
    func withFontHeletica(size : CGFloat) -> UIButton{
        self.titleLabel!.font = DJFont.helveticaFontOfSize(size)
        return self
    }
    
    func withFontHeleticaBold(size : CGFloat) -> UIButton{
        self.titleLabel!.font = DJFont.boldHelveticaFontOfSize(size)
        return self
    }
    
    func withFontHeleticaMedium(size : CGFloat) -> UIButton{
        self.titleLabel!.font = DJFont.mediumHelveticaFontOfSize(size)
        return self
    }
    
    func withTitle(title : String) -> UIButton {
        self.setTitle(title, forState: .Normal)
        return self
    }
    
    func withFont(font : UIFont) -> UIButton {
        self.titleLabel?.font = font
        return self
    }
    
    func withTitleColor(color : UIColor) -> UIButton {
        self.setTitleColor(color, forState: .Normal)
        return self
    }
    
    func withHighlightTitleColor(color : UIColor) -> UIButton {
        self.setTitleColor(color, forState: .Highlighted)
        return self
    }
    
    func withDisabledTitleColor(color : UIColor) -> UIButton {
        self.setTitleColor(color, forState: .Disabled)
        return self
    }
    
    func defaultTitleColor() -> UIButton{
        self.setTitleColor(UIColor.defaultBlack(), forState: UIControlState.Normal)
        return self
    }
    
    func withBackgroundImage(image : UIImage?) -> UIButton {
        setBackgroundImage(image, forState: state)
        return self
    }
    
    func withImage(image : UIImage?) -> UIButton {
        setImage(image, forState: state)
        return self
    }
    
}

extension UIColor {
    static func defaultBlack() -> UIColor {
        return UIColor(fromHexString: "262729")
    }
    
    static func defaultRed() -> UIColor {
        return UIColor(fromHexString: "f81f34")
    }
    
    static func gray81Color() -> UIColor {
        return UIColor(fromHexString: "818181")
    }
}

