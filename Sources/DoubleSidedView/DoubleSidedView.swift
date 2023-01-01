import SwiftUI

public struct DoubleSidedView<FrontView, BackView>: View where FrontView: View, BackView: View {
    
    private let isFlipped: Bool
    private let frontView: () -> FrontView
    private let backView: () -> BackView
    
    public var body: some View {
        FlipContainer(content: isFlipped, contentView: contentView)
    }
    
    public init(
        isFlipped: Bool,
        @ViewBuilder frontView: @escaping () -> FrontView,
        @ViewBuilder backView: @escaping () -> BackView
    ) {
        self.frontView = frontView
        self.backView = backView
        self.isFlipped = isFlipped
    }
    
    @ViewBuilder public func contentView(_ flipped: Bool) -> some View {
        if flipped {
            backView()
        } else {
            frontView()
        }
    }
}

extension Bool: Flippable {
    public var direction: FlipDirection {
        self ? .forward : .backward
    }
}

struct DoubleSidedView_Previews: PreviewProvider {
    
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
    
    static var previews: some View {
        DoubleSidedViewTest()
    }
}
