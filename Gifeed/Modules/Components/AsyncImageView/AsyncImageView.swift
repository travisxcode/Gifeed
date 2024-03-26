// @copyright Gifeed by TrevisXcode

import SwiftUI

struct CachedAsyncImage: View {
  let url: URL?
  
  var body: some View {
    if let cachedImage = ImageCacheRepository.shared.getImage(forKey: url) {
      cachedImage
        .resizable()
    } else {
      AsyncImage(url: url) { phase in
        switch phase {
        case .empty:
          ProgressView()
        case .success(let image):
          image.resizable()
            .onAppear {
              ImageCacheRepository.shared.setImage(image, forKey: url)
            }
        case .failure:
          Image(systemName: "photo")
        @unknown default:
          EmptyView()
        }
      }
    }
  }
}
