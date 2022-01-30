//
//  LaunchViewModel.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LaunchViewModel : ObservableObject {
    
    private let disposeBag = DisposeBag()
    private let _launches = BehaviorRelay<[Launch]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    private let apiHelper = APIHelper()
    
    var filteredLaunches: [Launch] = []
    
    var selectedYear = "" {
        didSet {
            filteredLaunches = _launches.value.filter({
                $0.dateUTC!.contains(selectedYear)
                && (
                    ($0.success == nil && $0.upcoming == true)
                    || ($0.success == true && $0.upcoming == false)
                )
            })
        }
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var launches: Driver<[Launch]> {
        return _launches.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfLaunches: Int {
        return filteredLaunches.count
    }
    
    init() {
        self.fetchLaunches()
    }
    
    func currentLaunch(at index: Int) -> Launch? {
        guard index < filteredLaunches.count else {
            return nil
        }
        return filteredLaunches[index]
    }
    
    func fetchLaunches() {
        self._launches.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = API.BASE_URL
        urlComponents.path = "\(API.API_VERSION)\(API.LAUNCHES_ENDPOINT)"

        debugPrint("API URL: \(String(describing: urlComponents.url))")

        apiHelper.request(fromURL: urlComponents.url!) { (result: Result<[Launch], Error>) in
            switch result {
            case .success(let launches):
                debugPrint("We got a successful result with: \(launches)")
                self._isFetching.accept(false)
                self._launches.accept(launches)
            case .failure(let error):
                debugPrint("We got a failure trying to get the weather. The error we got was: \(error.localizedDescription)")
                self._isFetching.accept(false)
                self._error.accept(error.localizedDescription)
            }
         }
    }
}
