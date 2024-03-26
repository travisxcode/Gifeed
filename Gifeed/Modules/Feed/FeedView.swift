// @copyright Gifeed by TrevisXcode

import Combine
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
    case fetchTrending
    case fetchTrendingSuccess([Gif])
  }
  
  @Dependency(\.trendingClient) var trendingClient
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .feedCards:
        return .none
      case .fetchTrending:
        return .run { send in
          if let gifs = try? await self.trendingClient.trending() {
            await send(.fetchTrendingSuccess(gifs))
          }
        }
      case .fetchTrendingSuccess(let gifs):
        gifs
          .map { FeedCard.State.Mapper.map($0) }
          .forEach { state.feedCards.insert($0, at: .zero) }
        return .none
      }
    }
    .forEach(\.feedCards, action: \.feedCards) {
      FeedCard()
    }
  }
}

struct FeedView: View {
  var store: StoreOf<Feed>
  
  var body: some View {
    ScrollView() {
      VStack(spacing: .zero) {
        ForEach(store.scope(state: \.feedCards, action: \.feedCards)) { store in
          FeedCardView(store: store)
        }
      }
    }
    .scrollIndicators(.hidden)
    .task {
      store.send(.fetchTrending)
    }
  }
}

#Preview {
  FeedView(
    store: Store(initialState: Feed.State()) {
      Feed()
    }
  )
}
