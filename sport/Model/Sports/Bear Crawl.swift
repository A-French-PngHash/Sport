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
    
    var intervalBetweenImages: Float = 0.3
    
    required init(numberOfSets: Int, timeOfTheExercise : Int) {
        self.numberOfSets = numberOfSets
        self.timeOfTheExercise = timeOfTheExercise
    }
    
    var name: String = "Bear Crawl"
    
    var specification: String = ""
    
    var numberOfSets: Int
    
    var numberOfImage: Int = 11
    
    var nameOfSoundFile: String = "Bear Crawl"

}
