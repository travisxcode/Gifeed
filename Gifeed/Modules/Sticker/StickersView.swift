// @copyright Gifeed by TrevisXcode

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
struct Stickers {
  @ObservableState
  struct State {
    var stickerItems = IdentifiedArrayOf<StickerItem.State>()
  }
  
  enum Action {
    case stickerItems(IdentifiedActionOf<StickerItem>)
    case fetchTrending
    case fetchTrendingSuccess([Gif])
  }
  
  @Dependency(\.trendingClient) var trendingClient
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .stickerItems:
        return .none
      case .fetchTrending:
        return .run { send in
          if let gifs = try? await self.trendingClient.stickers() {
            await send(.fetchTrendingSuccess(gifs))
          }
        }
      case .fetchTrendingSuccess(let gifs):
        gifs
          .map { StickerItem.State.Mapper.map($0) }
          .forEach { state.stickerItems.insert($0, at: .zero) }
        return .none
      }
    }
    .forEach(\.stickerItems, action: \.stickerItems) {
      StickerItem()
    }
  }
}

struct StickersView: View {
  var store: StoreOf<Stickers>
  
  var body: some View {
    ScrollView() {
      WaterfallGridView(
        store: Store(
          initialState: WaterfallGrid.State(
            items: store.stickerItems.elements,
            numOfColumns: 2
          )) { WaterfallGrid() })
    }
    .scrollIndicators(.hidden)
    .task {
      store.send(.fetchTrending)
    }
  }
}

#Preview {
  StickersView(
    store: Store(initialState: Stickers.State()) {
      Stickers()
    }
  )
}
