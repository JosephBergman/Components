//
//  RemoteImage.swift
//  Components
//
//  Created by JT Bergman on 1/14/20.
//  Copyright © 2020 Joseph Bergman. All rights reserved.
//


import SwiftUI

public struct RemoteImage<LoadingView: View, ErrorView: View, ImageView: View>: View {
    
    // MARK: Properties
    private let url: URL
    private let loadingView: () -> LoadingView
    private let imageView: (Image) -> ImageView
    private let errorView: (Error?) -> ErrorView
    @ObservedObject private var service = RemoteImageService()
    
    
    // MARK: Init
    public init(url: URL,
                @ViewBuilder loadingView: @escaping () -> LoadingView,
                @ViewBuilder imageView: @escaping (Image) -> ImageView,
                @ViewBuilder errorView: @escaping (Error?) -> ErrorView) {
        self.url = url
        self.loadingView = loadingView
        self.imageView = imageView
        self.errorView = errorView
    }
    
    
    // MARK: Body
    public var body: some View {
        switch service.state {
            
        case .loading:
            return AnyView(
                self.loadingView().onAppear {
                    self.service.fetchImage(url: self.url)
                }
            )
            
        case .image(let image):
            #if canImport(UIKit)
            return AnyView(
                self.imageView(Image(uiImage: image))
            )
            #elseif os(macOS)
            return AnyView(
                self.imageView(Image(nsImage: image))
            )
            #else
            return AnyView(
                errorView(nil)
            )
            #endif
            
        case .error(let error):
            return AnyView(
                errorView(error)
            )
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://images.unsplash.com/photo-1530319067432-f2a729c03db5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=980&q=80")!
        return RemoteImage(url: url, loadingView: {
            Image(systemName: "wifi")
        }, imageView: { image in
            image
        }, errorView: { error in
            Image(systemName: "wifi.slash")
        })
    }
}
