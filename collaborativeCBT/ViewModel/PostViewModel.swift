//
//  PostViewModel.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI
import Moya
import RxSwift

class PostsViewModel: ObservableObject {

    @Published var dummiePosts = Const.dummyPosts
    @Published var emotions: [String] = []
    @Published var selectedEmotions: [String] = []
    @Published var contexts: [String] = []
    @Published var selectedContexts: [String] = []
    @Published var emotionField = ""
    @Published var contextField = ""
    let provider = MoyaProvider<PostAPI>()
    
//    private lazy var service = MoyaProvider<PostAPI>()
    var disposeBag = DisposeBag()
    
    
    func newPost(text: String) {
            
        provider.rx.request(.newPost(text: text))
            .map(PostData.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.emotions = [data.sentiment]
                    self.contexts = data.keywords
                },
                onError: {
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)

    }
    
    func clearInputs() {
        emotions = []
        selectedEmotions = []
        contexts = []
        selectedContexts = []
        emotionField = ""
        contextField = ""
    }

    
    
    
          
}
    
    
    
