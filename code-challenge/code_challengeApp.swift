//
//  code_challengeApp.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import SwiftUI

@main
struct code_challengeApp: App {
    var body: some Scene {
        WindowGroup {
            FlickrListView(viewModel: FlickrListViewModel(flickrFetcher: FlickrAPI()))
        }
    }
}
