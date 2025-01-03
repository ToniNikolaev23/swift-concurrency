//
//  StrongSelfBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 3.01.25.
//

import SwiftUI

final class StrongSelfDataService {
    func getData() async -> String {
        "Updated data!"
    }
}

final class StrongSelfBootcampViewModel: ObservableObject {
    @Published var data: String = "Some title"
    let dataService = StrongSelfDataService()
    
    private var someTask: Task<Void, Never>? = nil
    private var myTasks: [Task<Void, Never>] = []
    
    func cancelTasks() {
        someTask?.cancel()
        someTask = nil
        
        myTasks.forEach({$0.cancel()})
        myTasks = []
    }
    
    // This implies a strong reference...
    func updateData() {
        Task {
            data = await dataService.getData()
        }
    }
    
    // This implies a strong reference...
    func updateData2() {
        Task {
            self.data = await dataService.getData()
        }
    }
    
    // This implies a strong reference...
    func updateData3() {
        Task { [self] in
            self.data = await dataService.getData()
        }
    }
    
    func updateData4() {
        Task { [weak self] in
            if let data = await self?.dataService.getData() {
                self?.data = data
            }
        }
    }
    
    func updateData5() {
        someTask = Task {
            self.data = await dataService.getData()
        }
    }
    
    func updateData6() {
        let task1 = Task {
            self.data = await dataService.getData()
        }
        
        myTasks.append(task1)
        
        let task2 = Task {
            self.data = await dataService.getData()
        }
        
        myTasks.append(task2)
    }
    
    func updateData7() {
        Task {
            self.data = await dataService.getData()
        }
        
        Task.detached {
//            self.data = await dataService.getData()
        }
    }
    
    func updateData8() async {
            self.data = await dataService.getData()
    }
}

struct StrongSelfBootcamp: View {
    @StateObject private var viewModel = StrongSelfBootcampViewModel()
    var body: some View {
        Text(viewModel.data)
            .onAppear {
                viewModel.updateData()
            }
            .onDisappear {
                viewModel.cancelTasks()
            }
            .task {
                await viewModel.updateData8()
            }
    }
}

#Preview {
    StrongSelfBootcamp()
}
