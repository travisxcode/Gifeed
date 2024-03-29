// @copyright Gifeed by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct StickerItem {
  @ObservableState
  struct State: Identifiable {
    var id: String { gifId }
    
    var gifId: String = ""
    var user: User?
    var gifUrl: String = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var sizeRatio: CGFloat {
      CGFloat(height) / CGFloat(width)
    }
  }
}

struct StickerItemView: View {
  @Bindable var store: StoreOf<StickerItem>
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      imageView
      
      if let user = store.user {
        headerView(user: user)
          .padding(12)
      }
    }
    .overlay(Rectangle().stroke(.black, lineWidth: 2))
  }
  
  private var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  @ViewBuilder
  private var imageView: some View {
    GifWebView(urlString: store.gifUrl)
      .overlay(
        store.user != nil ?
          LinearGradient(
            gradient: Gradient(
              colors: [.black, .clear, .clear, .clear]
            ),
            startPoint: .bottom,
            endPoint: .top
          )
          .opacity(0.7) :
          nil
      )
  }
  
  @ViewBuilder
  private func headerView(user: User) -> some View {
    HStack {
      CachedAsyncImage(url: URL(string: user.avatarUrl))
        .frame(width: 18, height: 18)
        .clipShape(Circle())
      
      Text(user.displayName)
        .font(.caption2)
        .bold()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
    }
  }

}

#Preview {
  StickerItemView(
    store: Store(
      initialState: StickerItem.State(
        user: User(
          avatarUrl: "https://media0.giphy.com/avatars/IntoAction/wTEVurMl2S4g.png",
          username: "IntoAction",
          displayName: "INTO ACTION"
        ),
        gifUrl: "https://media1.giphy.com/media/bgOQ2Mx4uLnsoyyIg9/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g",
        width: 480,
        height: 360
      )
    ) {
      StickerItem()
    }
  )
}
