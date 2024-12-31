//
//  TaskBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 31.12.24.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else {return}
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            
            await MainActor.run {
                self.image = UIImage(data: data)
                print("IMAGE RETURNED SUCCESSFULLY")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else {return}
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            
            await MainActor.run {
                self.image2 = UIImage(data: data)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Click me!") {
                    TaskBootcamp()
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    @StateObject private var viewModel = TaskBootcampViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
//        .onDisappear{
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            fetchImageTask = Task {
//                await viewModel.fetchImage()
//                
//            }
//            Task {
//                print(Thread())
//                print(Task.currentPriority)
//                await viewModel.fetchImage2()
//            }
            
//            Task(priority: .userInitiated) {
//                print("USER: \(Thread()) : \(Task.currentPriority)")
//            }
            
//            Task(priority: .high) {
////                try? await Task.sleep(nanoseconds: 2_000_000_000)
//                await Task.yield()
//                print("HIGH: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .medium) {
//                print("MEDIUM: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .low) {
//                print("LOW: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .utility) {
//                print("UTILITY: \(Thread()) : \(Task.currentPriority)")
//            }
//            Task(priority: .background) {
//                print("BACKGROUND: \(Thread()) : \(Task.currentPriority)")
//            }
           
            
//            Task(priority: .userInitiated) {
//                print("USER: \(Thread()) : \(Task.currentPriority)")
//                
//                Task.detached {
//                    print("USER: \(Thread()) : \(Task.currentPriority)")
//                }
//            }
           
//        }
    }
}

#Preview {
    TaskBootcamp()
}
