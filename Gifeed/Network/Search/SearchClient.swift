// @copyright Gifeed by TrevisXcode

import Combine
import Foundation
import Dependencies


struct SearchClient {
  var search: @Sendable (_ text: String) async throws -> [Gif]
}

extension SearchClient: DependencyKey {
  static let liveValue = Self(
    search: { text in
      var components = URLComponents(string: "https://api.giphy.com/v1/gifs/search")!
      components.queryItems = [
        URLQueryItem(name: "api_key", value: "\(GiphyApiKey)"),
        URLQueryItem(name: "q", value: text)
      ]
      let (data, _) = try await URLSession.shared.data(from: components.url!)

      do {
        let products = try searchJsonDecoder.decode(SearchClient.Response.self, from: data)
        return products.data
      } catch {
        // Print out the error causing the decoding to fail
        print("Failed to decode SearchClient.Response: \(error)")
        throw error
      }
    }
  )
}

extension DependencyValues {
  var searchClient: SearchClient {
    get { self[SearchClient.self] }
    set { self[SearchClient.self] = newValue }
  }
}


private let searchJsonDecoder: JSONDecoder = {
  let jsonDecoder = JSONDecoder()
  jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  return jsonDecoder
}()

extension SearchClient {
  struct Response: Decodable {
    var data: [Gif]
  }
  
}
