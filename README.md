# Chow Now

# Requirements

- Xcode 16 or later

# Compatability

- Requires iOS 17.0 or later.

# Usage

Open the chowNow.xcodeproj and hit run

# Technical Considerations

The app architecture is centered around using an ObservableObject in a ViewModel. The ObservableObject (CompanyLocationViewModel) invokes our APIClient and then publishes the values to our SwiftUI views once theyve been fetched. This separation allows us to create discrete testable elements. 


## Future improvements
- Some animations to improve the user experience


![](https://media.giphy.com/media/buWJ4V8cHZg88/giphy.gif?cid=ecf05e47hn9vfxt7vaujsei2k83ie4ep8kkst1okofvv16fo&rid=giphy.gif&ct=g)