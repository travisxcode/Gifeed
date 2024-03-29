// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer 
struct MainTabBar {
  @ObservableState 
  struct State {
    var selectedTab: Tab = .gifs
    var gifs = Gifs.State()
    var stickers = Stickers.State()
    
    enum Tab: Hashable {
      case gifs
      case stickers
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case setSelectedTab(State.Tab)
    case gifs(Gifs.Action)
    case stickers(Stickers.Action)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Scope(state: \.gifs, action: \.gifs) { Gifs() }
    Scope(state: \.stickers, action: \.stickers) { Stickers() }
    
    Reduce { state, action in
      switch action {
      case .setSelectedTab(let tab):
        state.selectedTab = tab
        return .none
      case .gifs:
        return .none
      case .stickers:
        return .none
      case .binding(_):
        return .none
      }
    }
  }
}

struct MainTabBarView: View {
  @Bindable var store: StoreOf<MainTabBar>
  
  var body: some View {
    TabView(selection: $store.selectedTab.sending(\.setSelectedTab)) {
      GifsView(store: store.scope(state: \.gifs, action: \.gifs))
        .tabItem { Label("Gifs", systemImage: "photo.stack") }
        .tag(MainTabBar.State.Tab.gifs)
      
      StickersView(store: store.scope(state: \.stickers, action: \.stickers))
        .tabItem { Label("Stickers", systemImage: "face.smiling") }
        .tag(MainTabBar.State.Tab.stickers)
    }
  }
}
