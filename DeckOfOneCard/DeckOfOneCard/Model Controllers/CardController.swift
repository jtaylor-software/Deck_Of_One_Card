//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Jeremy Taylor on 11/17/20.
//

import UIKit

class CardController {
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new")
    static let drawCardComponent = "draw"
    static let countComponent = "count"
    
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        
        let drawCardURL = baseURL.appendingPathComponent(drawCardComponent)
        
        var components = URLComponents(url: drawCardURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [URLQueryItem(name: countComponent, value: "1")]
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else { return completion(.failure(.noData))}
                completion(.success(card))
            } catch {
                print(error)
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
        URLSession.shared.dataTask(with: card.image) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            completion(.success(image))
            
        }.resume()
    }
}
