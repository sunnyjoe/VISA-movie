//
//  ListScrollView.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

protocol GenreListViewDelegate : NSObjectProtocol{
    func genreListViewDidSelectGenre(genre : MovieGenre?, listView : GenreListView)
}

let ListViewReuseCellName = "ListViewReuseCellName"

class GenreListView: UIView {
    private let tableView = UITableView()
    var movieGenreList = [MovieGenre]()
    weak var delegate : GenreListViewDelegate?
    private let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        contentView.frame = bounds
        addSubview(contentView)
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(didTapContainerView))
        tapG.delegate = self
        contentView.addGestureRecognizer(tapG)
         
        tableView.layer.borderColor = UIColor(fromHexString: "cecece").CGColor
        tableView.layer.borderWidth = 0.5
        tableView.separatorStyle = .None
        tableView.frame = CGRectMake(10, 57, 150, 459)
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addSubview(tableView)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ListViewReuseCellName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        tableView.reloadData()
    }
    
    func showAnimation() {
        let tmpSize = tableView.frame
        tableView.frame = CGRectMake(tmpSize.origin.x, tmpSize.origin.y, tmpSize.width, 10)
        UIView.animateWithDuration(0.2, animations: {
            self.tableView.frame = tmpSize
            })
    }
    
    func hideAnimation() {
        let tmpSize = tableView.frame
        UIView.animateWithDuration(0.2, animations: {
            self.tableView.frame = CGRectMake(tmpSize.origin.x, tmpSize.origin.y, tmpSize.width, 1)
            },completion: {(Bool) -> Void in
                self.removeFromSuperview()
                self.tableView.frame = tmpSize
        })
    }

    func didTapContainerView(){
        hideAnimation()
    }
}

extension GenreListView : UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view == nil {
            return false
        }
        
        if touch.view!.isDescendantOfView(tableView) {
            return false
        }
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movieGenreList.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tmp = tableView.dequeueReusableCellWithIdentifier(ListViewReuseCellName){
            cell = tmp
        }
        
        if indexPath.row == 0{
            cell.textLabel?.text = "-- All --"
        }else{
            let oneContact = movieGenreList[indexPath.row - 1]
            cell.textLabel?.text = oneContact.name
        }
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.textLabel?.textAlignment = .Center
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            delegate?.genreListViewDidSelectGenre(nil, listView: self)
        }else{
            let oneContact = movieGenreList[indexPath.row - 1]
            delegate?.genreListViewDidSelectGenre(oneContact, listView: self)
        }
    }
    
}
