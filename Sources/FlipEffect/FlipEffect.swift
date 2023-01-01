import SwiftUI

struct FlipEffect : GeometryEffect {
    
    @Binding var isFlipped: Bool
    
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat, z: CGFloat)
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        flipCheck()
        
        return transform3d(size).concatenating(affineTransform(size))
    }
    
    private func flipCheck() {
        // change should be scheduled after view has finished drawing
        // otherwise runtime error
        
        DispatchQueue.main.async {
            isFlipped = (angle.truncatingRemainder(dividingBy: 360) >= 90 && angle.truncatingRemainder(dividingBy: 360) < 270)
                   || (angle.truncatingRemainder(dividingBy: 360) <= -90 && angle.truncatingRemainder(dividingBy: 360) > -270)
        }
    }
    
    private func transform3d(_ size: CGSize) -> ProjectionTransform {
        let radianAngle = CGFloat(Angle(degrees: angle).radians)
        let scaleFactor = 0.5
        let scale = (abs(cos(Double(radianAngle))) * (1.0 - scaleFactor) + scaleFactor)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1 / max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, radianAngle, axis.x, axis.y, axis.z)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2.0, -size.height / 2.0, 0)
        transform3d = CATransform3DScale(transform3d, scale, 1.0, scale)
        return ProjectionTransform(transform3d)
    }
    
    private func affineTransform(_ size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: size.width / 2.0, y: size.height / 2.0))
    }
}

extension View {
    func flipEffect(isFlipped: Binding<Bool>, angle: Double, axis: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 1, 0)) -> some View {
        modifier(FlipEffect(isFlipped: isFlipped, angle: angle, axis: axis))
    }
}
