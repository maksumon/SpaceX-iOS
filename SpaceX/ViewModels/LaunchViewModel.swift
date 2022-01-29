//
//  LaunchViewModel.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import Foundation

class LaunchViewModel : ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    
    private let disposeBag = DisposeBag()
    private let _movies = BehaviorRelay<[Movie]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    private let apiHelper = APIHelper()
    
    func fetchLaunches() {
            self.isLoading = true
            
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = API.BASE_URL
            urlComponents.path = "\(API.API_VERSION)\(API.LAUNCHES_ENDPOINT)"
            
            debugPrint("API URL: \(String(describing: urlComponents.url))")
            
            apiHelper.request(fromURL: urlComponents.url!) { (result: Result<[Launch], Error>) in
                switch result {
                case .success(let launches):
                    debugPrint("We got a successful result with: \(launches)")
                    self.launches = launches
                    self.isLoading = false
                case .failure(let error):
                    debugPrint("We got a failure trying to get the weather. The error we got was: \(error.localizedDescription)")
                    self.isLoading = false
                }
             }
        }
}
