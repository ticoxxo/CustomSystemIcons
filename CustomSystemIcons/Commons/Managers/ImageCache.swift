//
//  ImageCache.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 10/02/26.
//
import SwiftUI


final class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSData, UIImage>()
    
    private init() {
            cache.countLimit = 50
            cache.totalCostLimit = 100 * 1024 * 1024 // 100MB
        }
    
    func image(for data: Data) -> UIImage? {
        // Check cache first
                if let cached = cache.object(forKey: data as NSData) {
                    return cached
                }
                
                // Decode if not cached
                guard let image = UIImage(data: data) else { return nil }
                cache.setObject(image, forKey: data as NSData)
                return image
    }
    
    func clearCache() {
            cache.removeAllObjects()
        }
    
}
