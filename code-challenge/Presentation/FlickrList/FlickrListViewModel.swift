//
//  FlickrListViewModel.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import Foundation
import Combine

enum ViewModelState<T> {
    case loading
    case loaded(T)
}

protocol FlickrListViewModelInterface: ObservableObject {
    var state: ViewModelState<[FlickrItem]> { get set }
    var hasFailed: Bool { get set }
    init(flickrFetcher: FlickrFetchable)
    func fetchFlickrList(tags: String)
}

class FlickrListViewModel {
    @Published var state: ViewModelState<[FlickrItem]> = .loading
    @Published var hasFailed = false

    private let flickrFetcher: FlickrFetchable
    private var disposables = Set<AnyCancellable>()

    private var flickrList = [FlickrItem]() {
        didSet {
            state = .loaded(flickrList)
        }
    }

    private var tags: String = "" {
        didSet {
            if tags != oldValue {
                flickrList.removeAll()
                state = .loading
            }
        }
    }

    required init(flickrFetcher: FlickrFetchable) {
        self.flickrFetcher = flickrFetcher
    }
}

//MARK: - FlickrListViewModelInterface Extension

extension FlickrListViewModel: FlickrListViewModelInterface {
    func fetchFlickrList(tags: String) {
        self.tags = tags
        disposables.removeAll()
        flickrFetcher
            .fetchFlickrList(tags: tags)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.hasFailed = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                let data = response.items
                self.flickrList = data
            }
            .store(in: &disposables)
    }
}
