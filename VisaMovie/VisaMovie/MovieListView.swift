//
//  MovieListView.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit


protocol MovieListViewDelegate : NSObjectProtocol{
    func movieListViewDidSelectMovie(movieInfo : MovieInfo, listView : MovieListView)
}

let MovieListViewReuseCellName = "MovieListViewReuseCellName"

class MovieListView: UIView {
    private let tableView = UITableView()
    var movieInfoList = [MovieInfo]()
    weak var delegate : MovieListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.separatorStyle = .None
        tableView.frame = bounds
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        
        tableView.registerClass(MoviewTableViewCell.self, forCellReuseIdentifier: MovieListViewReuseCellName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        tableView.reloadData()
    }
}

extension MovieListView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return min(movieInfoList.count, 10)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = MoviewTableViewCell()
        if let tmp = tableView.dequeueReusableCellWithIdentifier(MovieListViewReuseCellName) as? MoviewTableViewCell{
            cell = tmp
        }
        cell.selectionStyle = .None
        let oneMovie = movieInfoList[indexPath.row]
        var scoreStr : String?
        if let score = oneMovie.rating{
            scoreStr = "Score: \(score)"
        }
        let completion = {(name : String?) -> Void in
            if name != nil {
                cell.setInfo(oneMovie.imageUrl, title: oneMovie.title, score: scoreStr, genre: ("Genres: " + name!))
            }
        }
        DataContainer.sharedInstace.getGenreNamesFromId(oneMovie.genreIds, completion: completion)
        cell.setInfo(oneMovie.imageUrl, title: oneMovie.title, score: scoreStr, genre: oneMovie.language)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let oneContact = movieInfoList[indexPath.row]
        delegate?.movieListViewDidSelectMovie(oneContact, listView: self)
    }
    
}
