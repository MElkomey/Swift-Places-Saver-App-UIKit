//
//  Landmark.swift
//  Places Saver
//
//  Created by Mohamed Elkomey on 11/07/2023.
//

import Foundation
import RealmSwift

class Landmark:Object{
    @objc dynamic var name:String=""
    @objc dynamic var descreption:String=""
    @objc dynamic var longitude:Double=0.0
    @objc dynamic var Latitude:Double=0.0
    @objc dynamic var time:Date = Date()
}
