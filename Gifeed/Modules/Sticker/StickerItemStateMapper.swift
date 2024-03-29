// @copyright Gifeed by TrevisXcode

import Foundation

extension StickerItem.State {
  struct Mapper {
    static func map(_ gif: Gif) -> StickerItem.State {
      StickerItem.State(
        gifId: gif.id,
        user: gif.user,
        gifUrl: gif.images.original.url,
        width: Double(gif.images.original.width) ?? 0,
        height: Double(gif.images.original.height) ?? 0
      )
    }
  }
}
