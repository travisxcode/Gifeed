# Gifeed with The Composable Architecture (TCA)

This project provides an introduction to the practices of the Composable Architecture, from simple business logic to more sophisticated flows. TCA allows us to set up the project in a way that is systematically designed for modularization and reusability.

## Motivation

When starting a new project, it's important to consider which design patterns are best suited to the project's complexity. This project demonstrates practical, real-world problems and solutions using TCA. The aim is to showcase `TCA as the future of Swift development`, even extending beyond just iOS applications by providing basic examples and more intricate logic with  clear documentation and practical insights for using TCA in a realistic application context.

> Go TCA or go home

<img src="https://github.com/travisxcode/Gifeed/assets/17330548/ccdcd708-feba-4d12-bac9-83b71edd3d5b" width="70%" height="70%">

## TCA in the Nutshell
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/1f1b8d90-2383-45d4-9940-edf3dc6500a2" width="70%" height="70%">

The Composable Architecture (TCA) consists of the following key components:

> [!Note] 
> For full descriptive introduction to TCA, please visit [The Composable Architecture][tca-github] by our heroes [Brandon Williams][mbrandonw] and [Stephen Celis][stephencelis].

- Action: An `enum` type that represents all the possible events that can occur in your app which might affect the state. These can be user interactions like taps, system events, or other external events.
- Reducer: A `function` got called every time an action is sent to the store, responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
- State: A `struct` describes the data or the current conditions of the app that the Reducer can read and write. It’s what you're trying to transform or mutate when actions occur.
- Effect: An `asynchronous` operations that can dispatch new actions such as, fetching data from a network request, playing audio, and more. Effects allow the Reducer to handle tasks that are not instantaneous and need to integrate with the outside world through Dependency.
- Dependency: This provides the Reducer with any dependencies it needs to perform its work, such as API clients, analytics services, etc. The environment is used to `perform side effects`
- Store: A `runtime state management` that holds the entire state of a part of your application. It is initialized with the initial state which then evolves over time as actions are processed by the Reducer.

## Dive into feature Search

Let's start with the simpler view such search bar as the smaller feature component that will be later composed to larger view. We will break down the Swift code snippet to understand how each component contributes to the functionality of a search bar.

<img src="https://github.com/travisxcode/Gifeed/assets/17330548/acffaa14-d47d-499f-af49-ba246012f716" width="50%" height="50%">

The code snippet implements a SearchBar reducer and its corresponding view SearchBarView. The implementation uses TCA's state management and action handling to react to user inputs and perform search operations. Let's dissect the main components:

### The Reducer Declaration
The SearchBar structure is defined as a reducer with an observable state and a set of actions:
```swift
@Reducer
struct SearchBar {
  @ObservableState
  struct State {
    var textField: String = ""
  }
}
```

> [!Note]
> Here, the `@ObservableState` wrapper is used to automatically observe and respond to changes in the state. The state includes a single property, `textField`, representing the text input by the user.

### Actions Definition
The Action enum defines possible actions that can affect the state of the search bar:
```swift
enum Action: BindableAction, Equatable {
  case binding(BindingAction<State>)
  case textFieldChanged(String)
  case textFieldChangedRelay(String)
  case startSearch(String)
  case resetSearch
}
```

We almost immediately understand the behavior of what this feature component does just from reading list of `enum Action` and this is one of the highlights of `"What's in the TCA box 🎁"`
- binding: Supports automatic state mutations through bindings.
- textFieldChanged: Triggered when the text field content changes.
- textFieldChangedRelay: A relay action used for debouncing text input.
- startSearch: Commences the search process.
- resetSearch: Resets the search.

### Reducer Body
The body of the reducer manages the state transitions based on actions:
> Reducer reduces implementation

```swift
@Reducer
struct SearchBar {
  @ObservableState
  struct State { /* ... */ }
  enum Action: BindableAction, Equatable { /* ... */ }
  
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

      case .startSearch(_), .resetSearch, .binding:
        return .none
      }
    }
  }
}
```

The `.textFieldChanged` case introduces a 2-second delay (debouncing) before dispatching the `.textFieldChangedRelay` action, preventing excessive operations due to rapid text changes.

### View Implementation
The SearchBarView struct constructs the user interface:

> [!Note]
> Important part here is that it solves the issue upon text change firing to its subscriber twice, with [onChange(of:initial:_:)][onChange-doc]

```swift
struct SearchBarView: View {
  @Bindable var store: StoreOf<SearchBar>
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
      TextField("Search Giphy", text: $store.textField)
        .onChange(of: store.textField) { _, newValue in
          store.send(.textFieldChanged(newValue))
        }
    }
  }
}
```

This view binds a `TextField` to the store's textField state. It sends actions to the store based on user interactions, like text changes. 

Typically, when using `BindableAction` and `BindingReducer()` in the reducer's body, we receive notifications directly on text changes. However, with the dual-notification approach described above, we monitor text change events by using `store.send(.textFieldChanged(newValue))`.

## Composition
As the name suggests, the architecture enhances the feature component to be systematically `composable`. 😉

<img width="70%" height="70%" src="https://github.com/travisxcode/Gifeed/assets/17330548/75b33783-40db-498f-aa3c-13bab9fe390a">

## Screenshots
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/c1fda070-824f-48fd-b56d-fff1fd8d7657" width="22%" height="22%">
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/1c50b20e-6f65-4b12-8381-3e260e787f3c" width="22%" height="22%">
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/51a89c1a-b7e7-4f78-84d5-341b236fc6c6" width="22%" height="22%">

[tca-github]: https://github.com/pointfreeco/swift-composable-architecture?tab=readme-ov-file#basic-usage
[mbrandonw]: https://twitter.com/mbrandonw
[stephencelis]: https://twitter.com/stephencelis
[onChange-doc]: https://developer.apple.com/documentation/swiftui/view/onchange(of:initial:_:)-8wgw9
