//
//  CryptoViewModel.swift
//  CryptoConverterRx
//
//  Created by André Filipe Fonsêca Borba on 10/03/24.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    let cryptos: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().getCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Occurs Parsing Error")
                case .serverError:
                    self.error.onNext("Occurs Server Error")
                }
            }
        }
    }
}
