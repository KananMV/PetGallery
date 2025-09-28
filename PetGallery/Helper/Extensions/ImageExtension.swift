import UIKit

extension UIImageView {
    
    func makeBottomRounded(curveDepth: CGFloat) {
        let width = self.bounds.width
        let height = self.bounds.height
        
        let curveStartPointY = height - curveDepth
        
        let maskPath = UIBezierPath()
        
        maskPath.move(to: .zero)
        
        maskPath.addLine(to: CGPoint(x: width, y: 0))
        
        maskPath.addLine(to: CGPoint(x: width, y: curveStartPointY))
        
        maskPath.addQuadCurve(
            to: CGPoint(x: 0, y: curveStartPointY),
            controlPoint: CGPoint(x: width / 2, y: height)
        )
        
        maskPath.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
