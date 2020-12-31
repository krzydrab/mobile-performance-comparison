//
//  JuliaFractal.swift
//  SwiftFractal
//
//  Created by Krzysztof Drab on 30/07/2020.
//  Copyright © 2020 Krzysztof Drab. All rights reserved.
//

import SwiftUI
import UIKit

class JuliaFractalView: UIView {

    var startTime: Date = Date();
    
    // Implement this method if you load your view from storyboards or nib files and your view requires custom initialization.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.startTime = Date();
    }
    
    func createBitmapContext(pixelsWide: Int, _ pixelsHigh: Int) -> CGContext? {
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * pixelsWide
        let bitsPerComponent = 8

        let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
        let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue

        let context = CGContext(data: nil, width: pixelsWide, height: pixelsHigh, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)

        return context
    }

    override func draw(_ rect: CGRect) {
        let width  = 1200
        let height = 1200
        let boundingBox = CGRect(x: 0, y: 0, width: CGFloat(400), height: CGFloat(600))
        let context = createBitmapContext(pixelsWide: width, height)

        let data = context!.data
        
        // https://stackoverflow.com/a/39726570
        let opaquePtr = OpaquePointer(data!)
        let pixels = UnsafeMutablePointer<CUnsignedChar>(opaquePtr)

        let startingPoint = Date()
        let kOffset = startTime.timeIntervalSinceNow * -1;
        var dataOffset = 0;

        let minRe = -2.0;
        let maxRe = 2.0;
        let minIm = -1.5;
        let maxIm = 1.5;
        let reFactor = (maxRe-minRe)/Double(width);
        let imFactor = (maxIm-minIm)/Double(height-1);

        let kRe = 0.0 + sin(kOffset) * 0.4;
        let kIm = -0.5 + cos(kOffset) * 0.4;
        let maxIterations = 30;

        var y = 0;
        while y < height {
          // Map image coordinates to c on complex plane
          let cIm = maxIm - Double(y)*imFactor;
          var cRe = minRe;

          var x = 0;
          while x < width {
            // Z[0] = c
            var ZRe = cRe;
            var ZIm = cIm;

            // color channels order: BGRA
            pixels[dataOffset]     = 0;
            pixels[dataOffset + 1] = 0;
            pixels[dataOffset + 2] = 0;
            pixels[dataOffset + 3] = 255;

            var n = 0;
            while n < maxIterations {
              // Z[n+1] = Z[n]^2 + K
              // Z[n]^2 = (Z_re + Z_im*i)^2
              //        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
              //        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
              let ZRe2 = ZRe * ZRe;
              let ZIm2 = ZIm * ZIm;

              if(ZRe2 + ZIm2 > 4) {
                pixels[dataOffset + 2] = UInt8(min(60 + n * 8, 255));
                break;
              }

              ZIm = 2*ZRe*ZIm + kIm;
              ZRe = ZRe2 - ZIm2 + kRe;
                n += 1;
            }

            dataOffset += 4;
            x += 1;
            cRe += reFactor;
          }
          y += 1;
        }

        let image = context!.makeImage()!
        if let currentContext: CGContext = UIGraphicsGetCurrentContext() {
            currentContext.draw(image, in: boundingBox)
        }
        let time = startingPoint.timeIntervalSinceNow * -1;
//        print("Rendering time: \(String(format: "%.06f", time))");
    }
}

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-wrap-a-custom-uiview-for-swiftui
struct JuliaFractal: UIViewRepresentable {
    @Binding var updateTrigger: Bool;
    
    func makeUIView(context: Context) -> JuliaFractalView {
        let screenSize: CGRect = UIScreen.main.bounds
        return JuliaFractalView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
    }

    func updateUIView(_ uiView: JuliaFractalView, context: Context) {
        uiView.setNeedsDisplay();
    }
}

struct JuliaFractal_Previews: PreviewProvider {
    static var previews: some View {
        JuliaFractal(updateTrigger: .constant(false))
    }
}
