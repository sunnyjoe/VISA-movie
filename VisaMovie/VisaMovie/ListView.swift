//
//  ListScrollView.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

protocol GenreListViewDelegate : NSObjectProtocol{
    func genreListViewDidSelectGenre(genre : MovieGenre, listView : GenreListView)
}

let ListViewReuseCellName = "ListViewReuseCellName"

class GenreListView: UIView {
    private let tableView = UITableView()
    var movieGenreList = [MovieGenre]()
    weak var delegate : GenreListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.bounds = bounds
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ListViewReuseCellName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        tableView.reloadData()
    }
}

extension GenreListView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movieGenreList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tmp = tableView.dequeueReusableCellWithIdentifier(ListViewReuseCellName){
            cell = tmp
        }
        
        let oneContact = movieGenreList[indexPath.row]
        cell.textLabel?.text = oneContact.name
        cell.textLabel?.textColor = UIColor.blackColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let oneContact = movieGenreList[indexPath.row]
        delegate?.genreListViewDidSelectGenre(oneContact, listView: self)
    }

}
