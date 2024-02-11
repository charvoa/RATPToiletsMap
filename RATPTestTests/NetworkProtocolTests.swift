//
//  NetworkProtocolTests.swift
//  RATPTestTests
//
//  Created by Nicolas Charvoz on 11/02/2024.
//

import XCTest
@testable import RATPTest

private class NetworkProtocolTest: NetworkProtocol {
    var baseUrl: URL { return URL(string: "https://google.com")! }

    func fetchData(from: Int, limit: Int) async throws -> [RATPTest.ToiletteModel] {
        struct Response: Codable {
            struct Record: Codable {
                var fields: ToiletteModel
            }

            var records: [Record]
        }

        guard let data = responseJson.data(using: .utf8) else { return [] }

        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return response.records.compactMap { $0.fields }
        } catch {
            print(error)
            throw NetworkError.decodingFailure
        }
    }
}

final class NetworkProtocolTests: XCTestCase {
    func testParsing() async throws {
        let networkManager = NetworkProtocolTest()

        let items = try? await networkManager.fetchData(from: 0, limit: 20)

        XCTAssert((items?.count ?? 0) > 0)
    }

    func testHoraire() async throws {
        let networkManager = NetworkProtocolTest()
        let items = try? await networkManager.fetchData(from: 0, limit: 20)

        let firstItem = items?[0]

        let firstDH = firstItem?.displayHoraire

        XCTAssert(firstDH?.value(withLocale: Locale(identifier: "en_US_POSIX")).caseInsensitiveCompare("Ouvert de 6:00 AM à 10:00 PM") == .orderedSame)

        let secondItem = items?[2]

        let secondDH = secondItem?.displayHoraire

        XCTAssert(secondDH?.value(withLocale: Locale(identifier: "en_US_POSIX")).caseInsensitiveCompare("Ouvert 24h/24") == .orderedSame)
    }
}
