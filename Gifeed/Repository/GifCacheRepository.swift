// @copyright Gifeed by TrevisXcode

import UIKit

final class GifCacheRepository {
  static let shared = GifCacheRepository()
  private var cache = NSCache<NSURL, NSData>()
  
  func getGIFData(for request: URLRequest, completion: @escaping (Data?) -> Void) {
    guard let url = request.url else { return completion(nil) }
    if let cached = cache.object(forKey: url as NSURL) { return completion(cached as Data) }
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data, error == nil else { return completion(nil) }
      
      // Cache the downloaded data
      self.cache.setObject(data as NSData, forKey: url as NSURL)
      completion(data)
    }.resume()
  }
  
}
