//
//  RemoteImageService.swift
//  Components
//
//  Created by JT Bergman on 1/14/20.
//  Copyright © 2020 Joseph Bergman. All rights reserved.
//

import Foundation
import Combine


internal class RemoteImageService: ObservableObject {
    
    // MARK: Properties
    
    /// Broadcasts state changes as the image loads
    @Published var state: RemoteImageState = .loading
    
    /// Holds onto a cancellable for the image request
    private var cancellable: AnyCancellable?
    
    
    // MARK: Methods
    
    internal func fetchImage(url: URL) {
        // If there is an old request, cancel it
        cancellable?.cancel()
        
        // Check the cache and return the image if available
        if let image = RemoteImageCache.shared.getImage(url: url) {
            state = .image(image)
            return
        }
        
        // Download the image
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { PlatformImageType(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.state = .error(error)
                default:
                    break
                }
            }, receiveValue: { image in
                if let image = image {
                    RemoteImageCache.shared.addImage(image: image, withURL: url)
                    self.state = .image(image)
                } else {
                    self.state = .error(nil)
                }
            })
    }
}
