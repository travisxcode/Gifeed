// @copyright Gifeed by TrevisXcode

import Foundation

extension GifItem.State {
  struct Mapper {
    static func map(_ gif: Gif) -> GifItem.State {
      GifItem.State(
        gifId: gif.id,
        user: gif.user,
        gifUrl: gif.images.original.url,
        width: Double(gif.images.original.width) ?? 0,
        height: Double(gif.images.original.height) ?? 0
      )
    }
  }
}
