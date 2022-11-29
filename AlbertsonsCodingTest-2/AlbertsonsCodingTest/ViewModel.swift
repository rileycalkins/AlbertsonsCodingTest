//
//  ViewModel.swift
//  AlbertsonsCodingTest
//
//  Created by Riley Calkins on 11/23/22.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    let searchURLBase = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
    @Published var searchString = ""
    @Published var longFormObjects: [LongForm] = []
    
    func getAcronyms(for searchTerm: String, completion: @escaping ([AcronymResponse]) -> Void) {
        guard let url = URL(string: searchURLBase + searchTerm) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [AcronymResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: {
                response in
                completion(response)
            })
            .map({ response in
                return response.count > 0 ? response[0].lfs : []
            })
            .catch({ (error) in
                Just(self.longFormObjects)
            })
            .assign(to: &$longFormObjects)
    }
    
    func clearItems() {
        longFormObjects = []
    }
}
