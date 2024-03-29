// @copyright Gifeed by TrevisXcode

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
struct Gifs {
  @ObservableState
  struct State {
    var gifCards = IdentifiedArrayOf<GifCard.State>()
  }
  
  enum Action {
    case gifCards(IdentifiedActionOf<GifCard>)
    case fetchTrending
    case fetchTrendingSuccess([Gif])
  }
  
  @Dependency(\.trendingClient) var trendingClient
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .gifCards:
        return .none
      case .fetchTrending:
        return .run { send in
          if let gifs = try? await self.trendingClient.gifs() {
            await send(.fetchTrendingSuccess(gifs))
          }
        }
      case .fetchTrendingSuccess(let gifs):
        gifs
          .map { GifCard.State.Mapper.map($0) }
          .forEach { state.gifCards.insert($0, at: .zero) }
        return .none
      }
    }
    .forEach(\.gifCards, action: \.gifCards) {
      GifCard()
    }
  }
}

struct GifsView: View {
  var store: StoreOf<Gifs>
  
  var body: some View {
    ScrollView() {
      VStack(spacing: .zero) {
        ForEach(store.scope(state: \.gifCards, action: \.gifCards)) { store in
          GifCardView(store: store)
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
  GifsView(
    store: Store(initialState: Gifs.State()) {
      Gifs()
    }
  )
}
