// @copyright Gifeed by TrevisXcode

import SwiftUI

struct SimpleGifView: View {
  var gifUrl: String = ""
  
  var body: some View {
    GifWebView(urlString: gifUrl)
  }
}

#Preview {
  SimpleGifView(
    gifUrl: "https://media1.giphy.com/media/bgOQ2Mx4uLnsoyyIg9/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g"
  )
}
