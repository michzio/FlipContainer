# FlipContainer

A FlipContainer view in SwiftUI is a container view that allows you to flip between two views, 
similar to flipping a card over. When the user interacts with the view, such as by tapping it or swiping it, 
the front view is replaced with the back view, and vice versa.

# Usage - Cocoapods 

```
pod 'FlipContainer'
```

# Usage - Swift Package Manager

Once you have your Swift package set up, adding FlipContainer as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```
dependencies: [
    .package(url: "https://github.com/michzio/FlipContainer.git", .upToNextMajor(from: "0.1.0"))
]
```

# How to use 

You can use both FlipContainer directly to flip between multiple views 

```
    enum Card: String, Flippable, CaseIterable {
        case front
        case back
        case other
        
        var direction: FlipDirection {
            switch self {
            case .back, .other:
                return .forward
            case .front:
                return .backward
            }
        }
    }
    
    private struct FlipContainerTestView: View {
        
        @State private var content: Card = .front
        @State private var flipAngle: Double = 0.0
        
        var body: some View {
            FlipContainer(content: content) {
                switch $0 {
                case .front:
                    Text("Front")
                        .padding(20)
                        .frame(width: 200, height: 300)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
                        .onTapGesture {
                            content = .back
                        }
                case .back:
                    Text("Back")
                        .padding(20)
                        .frame(width: 200, height: 300)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                        .onTapGesture {
                            content = .other
                        }
                case .other:
                    Text("Other")
                        .padding(20)
                        .frame(width: 200, height: 300)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        .onTapGesture {
                            content = .front
                        }
                }
            }
        }
    }
```

Or you may just want to flip between two views (like back and front view)
Then you can use helper component DoubleSidedView.

```
    private struct DoubleSidedViewTest: View {
        
        @State private var isFlipped = false
        
        var body: some View {
            DoubleSidedView(isFlipped: isFlipped) {
                Text("Front")
                    .padding(20)
                    .frame(width: 200, height: 300)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
            } backView: {
                Text("Back")
                    .padding(20)
                    .frame(width: 200, height: 300)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
            }
            .onTapGesture {
                isFlipped.toggle()
            }
        }
    }
```
