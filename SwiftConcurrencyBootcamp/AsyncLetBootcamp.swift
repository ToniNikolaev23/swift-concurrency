//
//  AsyncLetBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 1.01.25.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    @State private var images: [UIImage] = []
    @State private var titleTest: String = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/300")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    
                    Text(titleTest)
                }
            }
            .navigationTitle("Async let")
            .onAppear {
                Task {
                    do {
                        
                        async let fetchImage1 = fetchImage()
                        async let fetchTitle = fetchTitle()
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        
                        let (image1, image2, image3, image4, title) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4, fetchTitle)
                        
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        self.titleTest = title
                        
//                        let image1 = try await fetchImage()
//                        self.images.append(image1)
//                        
//                        let image2 = try await fetchImage()
//                        self.images.append(image2)
//                        
//                        let image3 = try await fetchImage()
//                        self.images.append(image3)
//                        
//                        let image4 = try await fetchImage()
//                        self.images.append(image4)
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    func fetchTitle() async -> String {
        return "New title"
    }
    
    func fetchImage() async throws -> UIImage {
        do {
           let (data, _) = try await URLSession.shared.data(from: url,delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch  {
            throw error
        }
    }
}

#Preview {
    AsyncLetBootcamp()
}
