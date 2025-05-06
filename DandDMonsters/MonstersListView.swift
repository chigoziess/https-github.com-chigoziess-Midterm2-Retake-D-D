//
//  MonstersListView.swift
//  DandDMonsters
//
//  Created by Chigozie Sumani on 4/14/25.
//

import SwiftUI

struct MonstersListView: View {
    @State private var monstersVM = MonstersViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(monstersVM.monsters) { monster in
                    NavigationLink {
                        MonsterDetailView(monster: monster)
                    } label : {
                        Text(monster.name)
                            .font(.title2)
                    }
                }
                .listStyle(.plain)
                
                if monstersVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }

            }
            .navigationTitle("Monsters")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("\(monstersVM.monsters.count) Monsters")
                }
            }
        }
        .task {
            await monstersVM.getData()
        }
        .padding()
    }
}

#Preview {
    MonstersListView()
}
