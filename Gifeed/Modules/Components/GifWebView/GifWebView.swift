// @copyright Gifeed by TrevisXcode

import SwiftUI
import WebKit

struct GifWebView: UIViewRepresentable {
  var urlString: String
  
  func makeUIView(context: Context) -> WKWebView {
    let config = WKWebViewConfiguration()
    config.websiteDataStore = .nonPersistent()
    let webView = WKWebView(frame: .zero, configuration: config)
    loadGIF(webView: webView)
    return webView
  }
    
  private func loadGIF(webView: WKWebView) {
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
    request.httpShouldHandleCookies = false
    GifCacheRepository.shared.getGIFData(for: request) { data in
      guard let data else { return }
      
      DispatchQueue.main.async {
        webView.load(
          data,
          mimeType: "image/gif",
          characterEncodingName: "UTF-8",
          baseURL: url
        )
      }
    }
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) { }

}
