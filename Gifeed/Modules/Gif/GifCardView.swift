// @copyright Gifeed by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct GifCard {
  @ObservableState
  struct State: Identifiable {
    var id: String { gifId }
    var user: User?
    var gifId: String = ""
    var gifUrl: String = ""
    var width: CGFloat = 0
    var height: CGFloat = 0
    var trendingDateTime: String?
    
    var sizeRatio: CGFloat {
      CGFloat(height) / CGFloat(width)
    }
  }
}

struct GifCardView: View {
  @Bindable var store: StoreOf<GifCard>
  
  var body: some View {
    VStack {
      if let user = store.user {
        headerView(user: user)
          .padding([.leading, .trailing], 14)
          .padding(.top, 10)
      }
      
      imageView
        .padding(store.user != nil ? .bottom : [.top, .bottom], 10)
    }
  }
  
  @ViewBuilder
  private func headerView(user: User) -> some View {
    HStack {
      CachedAsyncImage(url: URL(string: user.avatarUrl))
        .frame(width: 28, height: 28)
        .clipShape(Circle())
      
      VStack(spacing: -2) {
        HStack(spacing: 4) {
          Text(user.displayName)
            .bold()
          
          if let trendingDateTime = store.trendingDateTime {
            Text("·")
              .foregroundColor(.gray)
            
            Text(trendingDateTime)
              .foregroundColor(.gray)
          }
          Spacer()
        }
        
        Text(user.username)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      Spacer()
    }
    .font(.caption)
  }
  
  private var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  @ViewBuilder
  private var imageView: some View {
    GifWebView(urlString: store.gifUrl)
      .frame(height: store.width < screenWidth 
             ? store.height
             : screenWidth * store.sizeRatio
      )
  }
}

#Preview {
  GifCardView(
    store: Store(
      initialState: GifCard.State(
        user: User(
          avatarUrl: "https://media0.giphy.com/avatars/IntoAction/wTEVurMl2S4g.png",
          username: "IntoAction",
          displayName: "INTO ACTION"
        ),
        gifUrl: "https://media1.giphy.com/media/bgOQ2Mx4uLnsoyyIg9/giphy.gif?cid=563879ecgow4o9w7fcohoe5pkifsspt6zy2mnwlmvpo3eqek&ep=v1_gifs_trending&rid=giphy.gif&ct=g",
        width: 360,
        height: 360,
        trendingDateTime: "Just now"
      )
    ) {
      GifCard()
    }
  )
}
