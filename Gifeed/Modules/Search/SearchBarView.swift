// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct SearchBar {
  @ObservableState
  struct State {
    var textField: String = ""
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case textFieldChanged(String)
    case textFieldChangedRelay(String)
    case startSearch(String)
    case resetSearch
  }
  
  enum CancelID { case timer }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .textFieldChanged(let text):
        return .run { send in
          try await Task.sleep(for: .seconds(2))
          await send(.textFieldChangedRelay(text))
        }
      case .textFieldChangedRelay(let text):
        return .run { [textField = state.textField] send in
          if text == textField {
            await send(text.isEmpty ? .resetSearch : .startSearch(text))
          }
        }
      case .startSearch(_):
        return .none
      case .resetSearch:
        return .none
      case .binding:
        return .none
      }
    }
  }
}

struct SearchBarView: View {
  @Bindable var store: StoreOf<SearchBar>
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .resizable()
        .foregroundColor(.gray)
        .frame(width: 18, height: 18)
        .padding(.leading)
        .foregroundColor(.gray)
      
      TextField(
        "Search Giphy",
        text: $store.textField
      )
      .foregroundColor(.white)
      .onChange(of: store.textField) { _, newValue in
        store.send(.textFieldChanged(newValue))
      }
      
      Spacer()
    }
    .frame(height: 34)
    .background(Color.gray.opacity(0.3))
    .cornerRadius(12)
    .padding([.leading, .trailing], 10)
  }
}

#Preview {
  SearchBarView(store: Store(initialState: SearchBar.State()) {
    SearchBar()
  })
}
