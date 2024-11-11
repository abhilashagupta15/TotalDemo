//
//  HomeViewModel.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    let id: Int
    @Published var postsDataArr = [PostsResponseModel]()
    weak var delegate: HandlePostsAPICallFlow?
    
    init(id: Int) {
        self.id = id
    }
    
    func loadPosts() {
        Task {
            switch await APIHelper.shared.getPostsApiCal(req: PostsRequestModel(id: id)) {
            case let .success(obj):
                postsDataArr = obj
                delegate?.handleSuccessFlow()
            case let .failure(err):
                delegate?.handleFailureFlow(errString: err.rawValue)
            }
        }
    }
}

protocol HandlePostsAPICallFlow: AnyObject {
    func handleSuccessFlow()
    func handleFailureFlow(errString: String)
}
