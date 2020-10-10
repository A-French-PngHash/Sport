//
//  Bear Crawl.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import Foundation
class BearCrawl : SportWithTimer {
    var timeOfTheExercise: Int = 60
    
    var intervalBetweenImages: Float = 0.2
    
    required init(numberOfSets: Int) {
        self.numberOfSets = numberOfSets
    }
    
    var name: String = "Bear Crawl"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 11
    
    var nameOfSoundFile: String

}
