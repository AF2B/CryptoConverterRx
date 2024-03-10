//
//  WebService.swift
//  CryptoConverterRx
//
//  Created by André Filipe Fonsêca Borba on 10/03/24.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parsingError
}

class WebService {
    func getCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
