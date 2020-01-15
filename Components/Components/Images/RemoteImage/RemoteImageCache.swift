//
//  RemoteImageCache.swift
//  Components
//
//  Created by JT Bergman on 1/14/20.
//  Copyright © 2020 Joseph Bergman. All rights reserved.
//

import Foundation


internal class RemoteImageCache {
    
    
    // MARK: Properties
    
    /// Shared instance to store objects across instance
    internal static let shared = RemoteImageCache()
    
    /// Cache that maps a URL to a PlatformImageType
    private let cache = NSCache<NSString, PlatformImageType>()
    
    
    // MARK: Initializer
    
    /// Initializer is marked private to create a shared cache
    private init() { }
    
    
    // MARK: Methods
    
    /// Gets an image from a cache if it exists, otherwise returns nil
    internal func getImage(url: URL) -> PlatformImageType? {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            return image
        }
        return nil
    }
    
    /// Stores an image to a cache using the image URL 
    internal func addImage(image: PlatformImageType, withURL url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    
}
