// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct Search {
  @ObservableState
  struct State {
    var searchBar = SearchBar.State()
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case searchBar(SearchBar.Action)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Scope(state: \.searchBar, action: \.searchBar) { SearchBar() }
    
    Reduce { state, action in
      switch action {
      case .searchBar(.startSearch(let text)):
        print("startSearch \(text)")
        return .none
      case .searchBar(.resetSearch):
        print("resetSearch")
        return .none
      case .searchBar:
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
    }
  }
}

#Preview {
  SearchView(store: Store(initialState: Search.State()) { Search() })
}
