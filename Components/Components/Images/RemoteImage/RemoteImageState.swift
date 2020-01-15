//
//  RemoteImageState.swift
//  Components
//
//  Created by JT Bergman on 1/14/20.
//  Copyright © 2020 Joseph Bergman. All rights reserved.
//

import Foundation


/// Represents the possible states of a remote image
internal enum RemoteImageState {
    case loading
    case image(_ image: PlatformImageType)
    case error(_ error: Error?)
}


