//
//  MVVMBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 3.01.25.
//

import SwiftUI

final class MyManagerClass {
    func getData() async throws -> String {
        "Some Data!"
    }
}

actor MyManagerActor {
    func getData() async throws -> String {
        "Some Data!"
    }
}

@MainActor
final class MVVMBootcampViewModel: ObservableObject {
    let managerClass = MyManagerClass()
    let managerActor = MyManagerActor()
    
    private var tasks: [Task<Void, Never>] = []
    
   @Published private(set) var myData: String = "Starting text"
    
    func calcelTasks() {
        tasks.forEach({$0.cancel()})
        tasks = []
    }
    

    func onCallToActionButtonPressed() {
        let task = Task {
            do {
                myData = try await managerActor.getData()
            } catch {
                print(error)
            }
        }
        
        tasks.append(task)
    }
}

struct MVVMBootcamp: View {
    @StateObject private var viewModel = MVVMBootcampViewModel()
    var body: some View {
        VStack {
            Button(action: {
                viewModel.onCallToActionButtonPressed()
            }, label: {
                Text(viewModel.myData)
            })
        }
        .onDisappear {
            viewModel.calcelTasks()
        }
    }
}

#Preview {
    MVVMBootcamp()
}
