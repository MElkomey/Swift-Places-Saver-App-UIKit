//
//  Places.swift
//  Places Saver
//
//  Created by Mohamed Elkomey on 11/07/2023.
//

import Foundation
import RealmSwift

class Places{
    static var shared = Places()
    var landmarks:Results<Landmark>!
    var userLangitude:Double = 0.0
    var userLatitude:Double = 0.0
    
    private init(){}
}
