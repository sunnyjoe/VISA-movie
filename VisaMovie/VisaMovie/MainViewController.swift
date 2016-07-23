//
//  MainViewController.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let genreListView = GenreListView(frame : UIScreen.mainScreen().bounds)
    let genreBtn = UIButton()
    let yearTF = UITextField()
    
    let movieListView = MovieListView()
    var selectedGenre : MovieGenre?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let completion = {(list : [MovieGenre]) -> Void in
            self.resetGenreList(list)
        }
        DataContainer.sharedInstace.getGenreList(completion)
        
        let topView = UIView(frame : CGRectMake(0, 0, view.frame.size.width, 64))
        view.addSubview(topView)
        buildTopView(topView)
        
        movieListView.delegate = self
        view.addSubview(movieListView)
        
        searchBtnDidTapped()
    }
    
    func movieListViewDidSelectMovie(movieInfo: MovieInfo, listView: MovieListView) {
        let infoVC = MovieInfoViewController(movieInfo : movieInfo)
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    func searchBtnDidTapped(){
        yearTF.resignFirstResponder()
        
        let one = SearchMovieNetTask()
        if let tmp = yearTF.text{
            let n = tmp.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if Int(n) > 0{
                one.yearRelased = Int(tmp)
            }
        }
        if let tmp = selectedGenre{
            one.genre = tmp.id
        }
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                self.movieListView.movieInfoList = SearchMovieNetTask.parseResultToMovieInfoList(data)
                self.movieListView.reloadData()
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("SearchMovieNetTask failed")
            print(error.description)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)
        
    }
    
    func genreBtnDidTapped() {
        if genreListView.superview == nil {
            view.addSubview(genreListView)
            genreListView.showAnimation()
        }else{
            genreListView.hideAnimation()
        }
    }
    
    func resetGenreList(movieGenreList : [MovieGenre]){
        genreListView.delegate = self
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
}

extension MainViewController: GenreListViewDelegate, UITextFieldDelegate, MovieListViewDelegate{
    func buildTopView(containView : UIView){
        genreBtn.frame = CGRectMake(10, 20, 150, 44)
        genreBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        genreBtn.setTitle("Select a genre", forState: .Normal)
        containView.addSubview(genreBtn)
        genreBtn.addTarget(self, action: #selector(genreBtnDidTapped), forControlEvents: .TouchUpInside)
        let borderV1 = UIView(frame : CGRectMake(genreBtn.frame.origin.x, 57, genreBtn.frame.size.width, 0.5))
        borderV1.backgroundColor = UIColor(fromHexString: "cecece")
        containView.addSubview(borderV1)
        
        yearTF.frame = CGRectMake(200, 22, 80, 40)
        yearTF.placeholder = "Year"
        yearTF.text = "2016"
        yearTF.textAlignment = .Center
//        yearTF.layer.borderWidth = 0.5
//        yearTF.layer.borderColor = UIColor(fromHexString: "cecece").CGColor
        yearTF.returnKeyType = .Done
        yearTF.keyboardType = .DecimalPad
        yearTF.delegate = self
        containView.addSubview(yearTF)
        let borderV2 = UIView(frame : CGRectMake(yearTF.frame.origin.x, 57, yearTF.frame.size.width, 0.5))
        borderV2.backgroundColor = UIColor(fromHexString: "cecece")
        containView.addSubview(borderV2)
        
        
       // let borderV = UIView(frame : CGRectMake(0, 63.5, view.frame.size.width, 0.5))
        //borderV.backgroundColor = UIColor(fromHexString: "cecece")
      //  containView.addSubview(borderV)
        
        let searchBtn = UIButton(frame : CGRectMake(view.frame.size.width - 20 - 40, 20, 44, 44))
        searchBtn.withImage(UIImage(named: "SearchIcon"))
        containView.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(searchBtnDidTapped), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        movieListView.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
