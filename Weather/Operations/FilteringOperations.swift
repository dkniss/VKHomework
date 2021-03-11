//
//  FilteringOperations.swift
//  Weather
//
//  Created by Daniil Kniss on 11.03.2021.
//

import UIKit



final class SepiaFilterOperation: Operation {

    var image: UIImage
    
    enum ImageState {
        case new, filtered
    }
    
    var imageState: ImageState = .new

    init(_ image: UIImage) {
        self.image = image
    }
    
    override func main() {
        guard !isCancelled else { return }
        if let filteredImage = applySepiaFilter(to: image) {
            self.image = filteredImage
            self.imageState = .filtered
        }
    }
    
    private func applySepiaFilter(to image: UIImage) -> UIImage? {
        guard
            !isCancelled,
            let data = image.pngData()
        else { return nil }
        
        let inputImage = CIImage(data: data)
        let context = CIContext(options: nil)
        
        guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        
        guard
            !isCancelled,
            let outputImage = filter.outputImage,
            let outImage = context.createCGImage(outputImage, from: outputImage.extent)
        else { return nil }
        
        return UIImage(cgImage: outImage)
    }
}
