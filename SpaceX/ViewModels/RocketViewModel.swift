//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class RocketViewModel {
    private let disposeBag = DisposeBag()
    private let _rocket = BehaviorRelay<Rocket?>(value: nil)
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    private let apiHelper = APIHelper()
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var rocket: Driver<Rocket?> {
        return _rocket.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    init() {
        self.fetchRocket()
    }
    
    func fetchRocket() {
        self._rocket.accept(nil)
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.ROCKET_ENDPOINT)"

        debugPrint("API URL: \(String(describing: urlComponents.url))")

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<Rocket, Error>) in
            switch result {
            case .success(let rocket):
                debugPrint("We got a successful result with: \(rocket)")
                self._isFetching.accept(false)
                self._rocket.accept(rocket)
            case .failure(let error):
                debugPrint("We got a failure trying to get the weather. The error we got was: \(error.localizedDescription)")
                self._isFetching.accept(false)
                self._error.accept(error.localizedDescription)
            }
         }
    }
}
