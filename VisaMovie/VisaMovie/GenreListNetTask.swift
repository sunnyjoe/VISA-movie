//
//  GenreListNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class GenreListNetTask: BaseNetTask {
    override func uri() -> String!
    {
        return "genre/movie/list"
    }
    
}
