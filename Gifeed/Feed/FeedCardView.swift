// @copyright Gifeed by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct FeedCard {
  @ObservableState
  struct State: Identifiable {
    var id: String { gifId }
    var avatarUrl: String = ""
    var displayName: String = "displayName"
    var username: String = "@username"
    var gifId: String = ""
  }
}

struct FeedCardView: View {
  @Bindable var store: StoreOf<FeedCard>
  
  var body: some View {
    VStack {
      headerView
      imageView
    }
  }
  
  @ViewBuilder
  private var headerView: some View {
    HStack {
      Image(systemName: "person.crop.circle.fill")
        .resizable()
        .frame(width: 38, height: 38)
      
      VStack(spacing: .zero) {
        Text(store.displayName)
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(store.username)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  private var imageView: some View {
    Image(Asset.Image.defaultImage.rawValue)
      .resizable()
      .scaledToFill()
      .frame(height: 300)
      .cornerRadius(24)
      .clipped()
  }
}

#Preview {
  FeedCardView(
    store: Store(
      initialState: FeedCard.State(
        displayName: "displayName",
        username: "@username"
      )
    ) {
      FeedCard()
    }
  )
}
