//
//  MainViewController.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let genreListView = GenreListView(frame : CGRectMake(0, 64, 150, 250))
    let genreBtn = UIButton()
    let yearTF = UITextField()
    
    var selectedGenre : MovieGenre?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let one = GenreListNetTask()
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            print(responseObject)
            if let data = responseObject as? NSDictionary {
                let movieGenreList = GenreListNetTask.parseResultToGenreList(data)
                self.resetGenreList(movieGenreList)
            }
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)
        
        let topView = UIView(frame : CGRectMake(0, 0, view.frame.size.width, 64))
        topView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(topView)
        buildTopView(topView)
    }
    
    func searchBtnDidTapped(){
        yearTF.resignFirstResponder()
        
        let one = SearchMovieNetTask()
        if let tmp = yearTF.text{
            one.yearRelased = Int(tmp)
        }
        if let tmp = selectedGenre{
            one.genre = tmp.id
        }
        
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            print(responseObject)
            //            if let data = responseObject as? NSDictionary {
            //                self.movieGenreList = GenreListNetTask.parseResultToGenreList(data)
            //            }
            
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = false
    }
    
}


extension MainViewController: GenreListViewDelegate, UITextFieldDelegate{
    func buildTopView(containView : UIView){
        genreBtn.frame = CGRectMake(10, 20, 150, 44)
        genreBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        genreBtn.setTitle("Select a genre", forState: .Normal)
        containView.addSubview(genreBtn)
        genreBtn.addTarget(self, action: #selector(genreBtnDidTapped), forControlEvents: .TouchUpInside)
        genreBtn.layer.borderColor = UIColor.blackColor().CGColor
        genreBtn.layer.borderWidth = 0.5
        
        yearTF.frame = CGRectMake(180, 25, 100, 30)
        yearTF.placeholder = "Year(2016)"
        yearTF.layer.borderColor = UIColor.blackColor().CGColor
        yearTF.layer.borderWidth = 0.5
        yearTF.returnKeyType = .Done
        yearTF.keyboardType = .NumberPad
        yearTF.delegate = self
        containView.addSubview(yearTF)
        
        let searchBtn = UIButton(frame : CGRectMake(290, 20, 60, 44))
        searchBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        searchBtn.setTitle("Search", forState: .Normal)
        containView.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(searchBtnDidTapped), forControlEvents: .TouchUpInside)
    }
    
    func genreBtnDidTapped() {
        if genreListView.superview == nil {
            view.addSubview(genreListView)
        }else{
            genreListView.removeFromSuperview()
        }
    }
    
    func resetGenreList(movieGenreList : [MovieGenre]){
        genreListView.delegate = self
        genreListView.layer.borderColor = UIColor.blackColor().CGColor
        genreListView.layer.borderWidth = 0.5
        genreListView.movieGenreList = movieGenreList
        genreListView.reloadData()
    }
    
    func genreListViewDidSelectGenre(genre: MovieGenre?, listView: GenreListView) {
        selectedGenre = genre
        if genre != nil {
            genreBtn.setTitle(genre!.name, forState: .Normal)
        }else{
            genreBtn.setTitle("All", forState: .Normal)
        }
        genreBtnDidTapped()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
