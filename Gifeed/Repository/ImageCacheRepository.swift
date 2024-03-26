// @copyright Gifeed by TrevisXcode

import SwiftUI

final class ImageCacheRepository {
  static let shared = ImageCacheRepository()
  private var cache: [URL: Image] = [:]
  
  private init() {}
  
  func getImage(forKey key: URL?) -> Image? {
    guard let key else { return nil }
    
    return cache[key]
  }
  
  func setImage(_ image: Image, forKey key: URL?) {
    guard let key else { return }

    cache[key] = image
  }
}
