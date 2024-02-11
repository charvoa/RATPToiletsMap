//
//  NetworkManager.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import Foundation

class NetworkManager: NetworkProtocol {
    var baseUrl: URL {
        return URL(string: "https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011")!
    }

    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func fetchData(from start: Int = 0, limit: Int = 20) async throws -> [ToiletteModel] {
        let requestUrl = baseUrl.appending("start", value: "\(start)").appending("rows", value: "\(limit)")

        guard let (data, response) = try? await URLSession.shared.data(from: requestUrl),
                let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailure
        }

        guard httpResponse.statusCode == 200 else {
            throw NetworkError.errorCode(httpResponse.statusCode)
        }

        struct Response: Codable {
            struct Record: Codable {
                var fields: ToiletteModel
            }

            var records: [Record]
        }

        do {
            let response = try jsonDecoder.decode(Response.self, from: data)
            return response.records.compactMap { $0.fields }
        } catch {
            print(error)
            throw NetworkError.decodingFailure
        }
    }
}
