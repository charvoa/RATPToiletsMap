//
//  NetworkProtocol.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case requestFailure
    case decodingFailure
    case errorCode(Int)
}

protocol NetworkProtocol {
    var baseUrl: URL { get }

    func fetchData(from: Int, limit: Int) async throws -> [ToiletteModelNetwork]
}
