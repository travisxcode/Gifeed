// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct Feed {
  @ObservableState
  struct State {
    var feedCards = IdentifiedArrayOf<FeedCard.State>()
  }
  
  enum Action {
    case feedCards(IdentifiedActionOf<FeedCard>)
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .feedCards:
        return .none
      }
    }.forEach(\.feedCards, action: \.feedCards) {
      FeedCard()
    }
  }
}

struct FeedView: View {
  var store: StoreOf<Feed>
  
  var body: some View {
    ScrollView {
      VStack(spacing: 14) {
        ForEach(store.scope(state: \.feedCards, action: \.feedCards)) { store in
          FeedCardView(store: store)
          
          Color.gray
            .frame(height: 1)
        }
      }.padding()
    }
  }
}

#Preview {
  FeedView(
    store: Store(
      initialState: Feed.State(
        feedCards: [
          FeedCard.State(gifId: "gif1"),
          FeedCard.State(gifId: "gif2"),
          FeedCard.State(gifId: "gif3")
        ]
      )
    ) {
      Feed()
    }
  )
}
