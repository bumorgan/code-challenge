//
//  FlickrDetailView.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import SwiftUI

struct FlickrDetailView: View {
    @State var data: FlickrItem

    init(data: FlickrItem) {
        self.data = data
    }

    var body: some View {
        List {
            AsyncImage(url: URL(string: data.media["m"] ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            .listRowInsets(EdgeInsets())
            Section {
                Text("Image title: \(data.title)")
                Text("Author: \(data.author)")
                Text("Description: \(data.description)")
                Text("Published at: \(data.publishedDate)")
            }
        }
    }
}

#Preview {
    FlickrDetailView(
        data: FlickrItem(
            title: "Title", 
            media: ["m": "https://live.staticflickr.com/65535/53786824636_21cb4a5a85_m.jpg"],
            author: "@Author",
            description: "Description",
            published: "2024-05-25T15:05:02Z"
        )
    )
}
