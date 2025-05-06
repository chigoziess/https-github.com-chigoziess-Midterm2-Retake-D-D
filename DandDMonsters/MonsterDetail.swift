//
//  MonsterDetail.swift
//  DandDMonsters
//
//  Created by Chigozie Sumani on 5/5/25.
//

import Foundation

struct MonsterDetail: Codable {
    var name: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hit_points: Int = 0
    var image: String? = ""
    
}
