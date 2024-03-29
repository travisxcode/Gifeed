// @copyright Gifeed by TrevisXcode

import Combine
import Dependencies
import Foundation

extension TrendingClient: TestDependencyKey {
  static let previewValue = Self(
    gifs: { gifsMock },
    stickers: { gifsMock }
  )
}

private let gifsMock = [
  gifSquareMock(id: "111"),
  gifSquareMock(id: "222"),
  gifMock(id: "333"),
  gifMock(id: "444"),
  gifSquareMock(id: "555"),
  gifSquareMock(id: "666"),
  gifMock(id: "777"),
  gifSquareMock(id: "888"),
  gifMock(id: "999"),
  gifSquareMock(id: "000")
]

private func gifMock(id: String) -> Gif {
  Gif(
    id: id,
    url: "https://giphy.com/gifs/IntoAction-sunglasses-tap-water-clean-is-a-right-bgOQ2Mx4uLnsoyyIg9",
    username: "IntoAction",
    user: userMocks,
    importDatetime: "2024-03-23 01:43:01",
    images: Gif.Images(
      original: Gif.Image(
        height: "360",
        width: "480",
        url: "https://media1.giphy.com/media/bgOQ2Mx4uLnsoyyIg9/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g"
      )
    ), 
    trendingDatetime: "0000-00-00 00:00:00"
  )
}

private func gifSquareMock(id: String) -> Gif {
  Gif(
    id: id,
    url: "https://giphy.com/gifs/IntoAction-sunglasses-tap-water-clean-is-a-right-bgOQ2Mx4uLnsoyyIg9",
    username: "IntoAction",
    user: userMocks,
    importDatetime: "2024-03-23 01:43:01",
    images: Gif.Images(
      original: Gif.Image(
        height: "480",
        width: "480",
        url: "https://media1.giphy.com/media/bgOQ2Mx4uLnsoyyIg9/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g"
      )
    ), 
    trendingDatetime: "0000-00-00 00:00:00"
  )
}

private let userMocks = User(
  avatarUrl: "https://media0.giphy.com/avatars/IntoAction/wTEVurMl2S4g.png",
  username: "IntoAction",
  displayName: "INTO ACTION"
)
