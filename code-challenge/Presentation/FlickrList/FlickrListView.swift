//
//  FlickrListView.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import SwiftUI

struct FlickrListView<ViewModel>: View where ViewModel: FlickrListViewModelInterface {
    @StateObject private var viewModel: ViewModel
    @State private var searchText: String = ""
    @State var id = 0

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView().onAppear { viewModel.fetchFlickrList(tags: searchText) }
                case .loaded(let flickrList):
                    createFlickrGrid(with: flickrList)
                }
            }
            .navigationTitle("Flickr")
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                viewModel.fetchFlickrList(tags: searchText)
            }
        }
        .alert("Something went wrong", isPresented: $viewModel.hasFailed) {
            Button("Try again") {
                viewModel.hasFailed = false
                viewModel.fetchFlickrList(tags: searchText)
            }
        }
    }

    private func createFlickrGrid(with list: [FlickrItem]) -> some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity))], spacing: 10) {
                ForEach(list, id: \.self) { item in
                    NavigationLink {
                        FlickrDetailView(data: item)
                    } label: {
                        createItem(with: item)
                    }
                }
            }
        }
    }

    private func createItem(with item: FlickrItem) -> some View {
        AsyncImage(url: URL(string: item.media["m"] ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .aspectRatio(1, contentMode: .fit)
        } placeholder: {
            Color.gray
        }
    }
}

#Preview {
    FlickrListView(viewModel: FlickrListViewModel(flickrFetcher: FlickrAPI()))
}
