// @copyright Gifeed by TrevisXcode

import Combine
import Dependencies
import Foundation

extension TrendingClient: TestDependencyKey {
  static let previewValue = Self(
    trending: {
      [
        Gif(
          id: "bgOQ2Mx4uLnsoyyIg9",
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
          ), trendingDatetime: "0000-00-00 00:00:00"
        ),
        Gif(
          id: "bFmkCZcb5PTg1grbSe",
          url: "https://giphy.com/gifs/travisband-birthday-travis-fran-healy-bFmkCZcb5PTg1grbSe",
          username: "",
          user: nil,
          importDatetime: "2021-08-29 05:30:04",
          images: Gif.Images(
            original: Gif.Image(
              height: "360",
              width: "480",
              url: "https://media3.giphy.com/media/bFmkCZcb5PTg1grbSe/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g"
            )
          ), 
          trendingDatetime: "2020-02-27 07:30:07"
        ),
        Gif(
          id: "bFmkCZc5b5PTg1grbSe",
          url: "https://giphy.com/gifs/travisband-birthday-travis-fran-healy-bFmkCZcb5PTg1grbSe",
          username: "IntoAction",
          user: userMocks,
          importDatetime: "2021-08-29 05:30:04",
          images: Gif.Images(
            original: Gif.Image(
              height: "360",
              width: "480",
              url: "https://media3.giphy.com/media/bFmkCZcb5PTg1grbSe/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g"
            )
          ), 
          trendingDatetime: "0000-00-00 00:00:00"
        )
        
      ]
    }
  )
}

private let userMocks = User(
  avatarUrl: "https://media0.giphy.com/avatars/IntoAction/wTEVurMl2S4g.png",
  username: "IntoAction",
  displayName: "INTO ACTION"
)
