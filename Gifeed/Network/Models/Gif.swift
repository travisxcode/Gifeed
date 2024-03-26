// @copyright Gifeed by TrevisXcode

import Foundation

struct Gif: Decodable {
  var id: String
  var url: String
  var username: String
  var user: User?
  var importDatetime: String
  var images: Images
  var trendingDatetime: String
  
  struct Images: Decodable {
    var original: Image
  }
  
  struct Image: Decodable {
    var height: String
    var width: String
    var url: String
  }
}
