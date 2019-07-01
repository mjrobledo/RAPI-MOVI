
//
//  Textos.swift
//  Movies
//
//
//  Created by Miguel Robledo Vera on 07/06/19.
//  Copyright © 2019 Miguel Robledo Vera. All rights reserved.
//
import UIKit

func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}


extension String {
    
    //MARK: - Generals
    static let yes = NSLocalizedString("Si")
    static let popular = NSLocalizedString("popular")
    static let mostVoted = NSLocalizedString("mostVoted")
    static let upcoming = NSLocalizedString("upcoming")
    
    
    
    
}
