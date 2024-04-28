// @copyright Gifeed by TrevisXcode

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
struct SearchGifs {
  @ObservableState
  struct State {
    var gifCards = IdentifiedArrayOf<GifItem.State>()
  }
  
  enum Action {
    case gifCards(IdentifiedActionOf<GifItem>)
  }
    
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .gifCards:
        return .none
      }
    }
    .forEach(\.gifCards, action: \.gifCards) {
      GifItem()
    }
  }
}

struct SearchGifsView: View {
  var store: StoreOf<SearchGifs>
  
  var body: some View {
    ScrollView() {
      WaterfallGridView(
        store: Store(
          initialState: WaterfallGrid.State(
            items: store.gifCards.elements,
            numOfColumns: 2
          )
        ) { WaterfallGrid() }
      )
    }
    .scrollIndicators(.hidden)
  }
}

#Preview {
  GifsView(
    store: Store(initialState: Gifs.State()) {
      Gifs()
    }
  )
}
