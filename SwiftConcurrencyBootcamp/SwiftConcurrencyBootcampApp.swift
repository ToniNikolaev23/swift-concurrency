//
//  SwiftConcurrencyBootcampApp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 30.12.24.
//

import SwiftUI

@main
struct SwiftConcurrencyBootcampApp: App {
    var body: some Scene {
        WindowGroup {
            DownloadImageAsync()
        }
    }
}
