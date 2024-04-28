// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct Search {
  @ObservableState
  struct State {
    var searchQuery = ""
    var searchBar = SearchBar.State()
    var searchGifs = SearchGifs.State()
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case searchBar(SearchBar.Action)
    case searchGifs(SearchGifs.Action)
    
    case search
    case searchSuccess([Gif])
  }
  
  @Dependency(\.searchClient) var searchClient
  private enum CancelID { case gifs, stickers }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Scope(state: \.searchBar, action: \.searchBar) { SearchBar() }
    
    Scope(state: \.searchGifs, action: \.searchGifs) { SearchGifs() }
    
    Reduce { state, action in
      switch action {
      case .searchBar(.startSearch(let text)):
        print("startSearch \(text)")
        state.searchQuery = text
        
        guard !state.searchQuery.isEmpty else {
          state.searchGifs.gifCards = []
          return .cancel(id: CancelID.gifs)
        }
        
        return .run { send in await send(.search) }
      case .searchBar(.resetSearch):
        print("resetSearch")
        state.searchGifs.gifCards = []
        return .cancel(id: CancelID.gifs)
      case .searchBar:
        return .none
      case .search:
        guard !state.searchQuery.isEmpty else {
          return .none
        }
        
        return .run { [query = state.searchQuery] send in
          if let gifs = try? await self.searchClient.search(query) {
            await send(.searchSuccess(gifs))
          }
        }
        .cancellable(id: CancelID.gifs)
        
      case .searchSuccess(let gifs):
        gifs
          .map { GifItem.State.Mapper.map($0) }
          .forEach { state.searchGifs.gifCards.insert($0, at: .zero) }
        return .none
      case .searchGifs:
        return .none
      case .binding(_):
        return .none
      }
    }
  }
}

struct SearchView: View {
  var store: StoreOf<Search>
  
  var body: some View {
    VStack {
      SearchBarView(
        store: store.scope(state: \.searchBar, action: \.searchBar)
      )
      SearchGifsView(
        store: store.scope(state: \.searchGifs, action: \.searchGifs)
      )
    }
  }
}

#Preview {
  SearchView(store: Store(initialState: Search.State()) { Search() })
}
