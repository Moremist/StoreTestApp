//
//  NetworkService.swift
//  StoreTestApp
//
//  Created by Roman Kuzmich on 22.03.2023.
//

import Foundation

class NetworkService {
        
    func fetchData<T: Decodable>(urlString: String) async -> T? {
        guard let url = URL(string: urlString) else {
            print("Invalid URLString")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                return decodedResponse
            }
        } catch {
            print("Invalid data")
            return nil
        }
        return nil
    }
}
