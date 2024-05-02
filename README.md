# Gifeed with The Composable Architecture (TCA)

This project provides an introduction to the practices of the Composable Architecture, from simple business logic to more sophisticated flows. TCA allows us to set up the project in a way that is systematically designed for modularization and reusability.

# Motivation

When starting a new project, it's important to consider which design patterns are best suited to the project's complexity. This project demonstrates practical, real-world problems and solutions using TCA. The aim is to showcase TCA as the future of Swift development, even extending beyond just iOS applications.

> Go TCA or go home

This demo serves as an example TCA project, providing basic examples and more intricate logic. It offers clear documentation and practical insights for using TCA in a realistic application context.

# Screenshots
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/c1fda070-824f-48fd-b56d-fff1fd8d7657" width="22%" height="22%">
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/1c50b20e-6f65-4b12-8381-3e260e787f3c" width="22%" height="22%">
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/51a89c1a-b7e7-4f78-84d5-341b236fc6c6" width="22%" height="22%">

# TCA in the Nutshell
<img src="https://github.com/travisxcode/Gifeed/assets/17330548/c9c0450d-578c-4520-9517-b3299c923280" width="70%" height="70%">

To build a feature using the Composable Architecture you define some types and values that model your domain:

- State: A `struct` describes the data for your feature to perform the logic and render the UI, always has the default value.
- Action: An `enum` type that represents the actions in your feature; user interaction, API network calls, event sources and more.
- Reducer: A `function` that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
- Store: The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.
