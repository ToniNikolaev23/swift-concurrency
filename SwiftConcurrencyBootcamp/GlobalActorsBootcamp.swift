//
//  GlobalActorsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 2.01.25.
//

import SwiftUI

@globalActor struct MyFirstGlobalActor {
    static var shared = MyNewDataManager()
}

actor MyNewDataManager {
    
    func getDataFromDatabase() -> [String] {
        return ["One", "Two", "Three", "Four"]
    }
}

class GlobalActorsBootcampViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    let manager = MyFirstGlobalActor.shared
    
    @MyFirstGlobalActor
    func getData() {
        
        Task {
            let data = await manager.getDataFromDatabase()
             self.dataArray = data
        }
      
    }
    
}

struct GlobalActorsBootcamp: View {
    @StateObject private var viewModel = GlobalActorsBootcampViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) { test in
                    Text(test)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActorsBootcamp()
}
