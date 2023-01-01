import SwiftUI

public struct FlipContainer<ContentView, Content>: View where ContentView: View, Content: Hashable, Content: Flippable {
    
    @State private var isFlipped = false
    @State private var flipAngle: Double = 0
   
    @State private var content: Content
    
    private let flipDestination: Content
    private let axis: (x: CGFloat, y: CGFloat, z: CGFloat)
    private let contentView: (Content) -> ContentView
    
    public var body: some View {
        ZStack {
            contentView(content)
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: axis)
        .flipEffect(isFlipped: $isFlipped, angle: flipAngle, axis: axis)
        .onChange(of: isFlipped) { _ in
            if flipDestination != content {
                content = flipDestination
            }
        }
        .onChange(of: flipDestination) { destination in
            guard destination != content else { return }
            withAnimation(Animation.linear(duration: 1.0)) {
                flipAngle += destination.direction.rawValue
            }
        }
    }
    
    public init(
        content: Content,
        axis: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 1, 0),
        @ViewBuilder contentView: @escaping (Content) -> ContentView
    ) {
        self.axis = axis
        self.contentView = contentView
        self.flipDestination = content
        
        _content = State(wrappedValue: content)
    }
}

struct FlipContainer_Previews: PreviewProvider {
    
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
    
    static var previews: some View {
        FlipContainerTestView()
    }
}
