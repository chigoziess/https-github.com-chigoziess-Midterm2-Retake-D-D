//
//  MonstersViewModel.swift
//  DandDMonsters
//
//  Created by Chigozie Sumani on 4/14/25.
//

import Foundation

@Observable
class MonstersViewModel {
    struct Results: Codable {
        var count: Int
        var results: [Monster]
    }
    
    var count: Int = 0
    var monsters: [Monster] = []
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
            guard let returned = try? JSONDecoder().decode(Results.self, from: data) else {
                isLoading = false
                return
            }
            print("JSON returned")
            Task { @MainActor in
                self.count = returned.count
                self.monsters = returned.results
                isLoading = false
            }
        } catch {
            isLoading = false
            print("ERROR")
        }
        
    }
}
