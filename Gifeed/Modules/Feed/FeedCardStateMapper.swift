// @copyright Gifeed by TrevisXcode

import Foundation

extension FeedCard.State {
  struct Mapper {
    static var dateFormatter: DateFormatter {
      let inputFormatter = DateFormatter()
      inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      return inputFormatter
    }
    
    static func map(_ gif: Gif) -> FeedCard.State {
      FeedCard.State(
        user: gif.user,
        gifId: gif.id,
        gifUrl: gif.images.original.url,
        width: Double(gif.images.original.width) ?? 0,
        height: Double(gif.images.original.height) ?? 0,
        trendingDateTime: convertDateString(gif.trendingDatetime)
      )
    }
    
    private static func convertDateString(_ dateString: String) -> String? {
      guard dateString != "0000-00-00 00:00:00" else {
        return "Just now"
      }
      
      guard let date = dateFormatter.date(from: dateString) else {
        return nil
      }
      
      let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = "dd/M/yy"
      return outputFormatter.string(from: date)
    }
    
  }
}
