// @copyright Gifeed by TrevisXcode

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
struct Gifs {
  @ObservableState
  struct State {
    var gifCards = IdentifiedArrayOf<GifItem.State>()
    var displayType: DisplayType = .gifs
    var numOfColumns: Int {
      switch displayType {
      case .gifs:
        return 2
      case .stickers:
        return 3
      }
    }
    
    enum DisplayType {
      case gifs
      case stickers
    }
  }
  
  enum Action {
    case gifCards(IdentifiedActionOf<GifItem>)
    case fetchTrending
    case fetchTrendingGif
    case fetchTrendingSticker
    case fetchTrendingSuccess([Gif])
  }
  
  @Dependency(\.trendingClient) var trendingClient
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .gifCards:
        return .none
      case .fetchTrending:
        switch state.displayType {
        case .gifs:
          return .run { send in await send(.fetchTrendingGif) }
        case .stickers:
          return .run { send in await send(.fetchTrendingSticker) }
        }
      case .fetchTrendingGif:
        return .run { send in
          if let gifs = try? await self.trendingClient.gifs() {
            await send(.fetchTrendingSuccess(gifs))
          }
        }
      case .fetchTrendingSticker:
        return .run { send in
          if let gifs = try? await self.trendingClient.stickers() {
            await send(.fetchTrendingSuccess(gifs))
          }
        }
      case .fetchTrendingSuccess(let gifs):
        gifs
          .map { GifItem.State.Mapper.map($0) }
          .forEach { state.gifCards.insert($0, at: .zero) }
        return .none
      }
    }
    .forEach(\.gifCards, action: \.gifCards) {
      GifItem()
    }
  }
}

struct GifsView: View {
  var store: StoreOf<Gifs>
  
  var body: some View {
    ScrollView() {
      WaterfallGridView(
        store: Store(
          initialState: WaterfallGrid.State(
            items: store.gifCards.elements,
            numOfColumns: store.numOfColumns
          )
        ) { WaterfallGrid() }
      )
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
