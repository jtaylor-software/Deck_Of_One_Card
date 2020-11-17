//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Jeremy Taylor on 11/17/20.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
}
