// @copyright Gifeed by TrevisXcode

import Combine
import Foundation
import Dependencies

typealias APIKey = String
let GiphyApiKey: APIKey = "6xr0s2viYs1cjsCoTmaUDEJSEAPBH2xv"

struct TrendingClient {
  var trending: @Sendable () async throws -> [Gif]
}

extension TrendingClient: DependencyKey {
  static let liveValue = Self(
    trending: {
      let (data, _) = try await URLSession.shared
        .data(from: URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=\(GiphyApiKey)")!)
      do {
        let products = try trendingJsonDecoder.decode(TrendingClient.Response.self, from: data)
        return products.data
      } catch {
        // Print out the error causing the decoding to fail
        print("Failed to decode TrendingClient.Response: \(error)")
        throw error
      }
    }
  )
}

extension DependencyValues {
  var trendingClient: TrendingClient {
    get { self[TrendingClient.self] }
    set { self[TrendingClient.self] = newValue }
  }
}


private let trendingJsonDecoder: JSONDecoder = {
  let jsonDecoder = JSONDecoder()
  jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  return jsonDecoder
}()

extension TrendingClient {
  struct Response: Decodable {
    var data: [Gif]
  }
  
}
