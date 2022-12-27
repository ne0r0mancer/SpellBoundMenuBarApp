//
//  SBService.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

class Webservice {

    func getCorrectionForText(text: String, url: URL) async throws -> [Correction] {

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode([Correction].self, from: data)
    }

}

