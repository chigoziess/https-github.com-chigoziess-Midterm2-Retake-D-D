//
//  MonsterDetailViewModel.swift
//  DandDMonsters
//
//  Created by Chigozie Sumani on 5/5/25.
//

import Foundation

@Observable
class MonsterDetailViewModel {
    var name: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hitPoints: Int = 0
    var imageURL: String? = ""
    
    var baseURL = "https://www.dnd5eapi.co"
    var urlString = "https://www.dnd5eapi.co/api/2014/monsters"
    var isLoading = false
    
    func getData() async {
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        do {
            let configuration = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: configuration)
            let (data, _) = try await session.data(from: url)
            guard let monsterDetail = try? JSONDecoder().decode(MonsterDetail.self, from: data) else {
                isLoading = false
                return
            }
            print("JSON returned")
            Task { @MainActor in
                self.name = monsterDetail.name
                self.size = monsterDetail.size
                self.type = monsterDetail.type
                self.alignment = monsterDetail.alignment
                self.hitPoints = monsterDetail.hit_points
                self.imageURL = baseURL + (monsterDetail.image ?? "")
                isLoading = false
            }
        } catch {
            isLoading = false
            print("ERROR")
        }
        
    }
}

