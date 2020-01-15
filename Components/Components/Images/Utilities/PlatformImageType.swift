//
//  PlatformImageType.swift
//  Components
//
//  Created by JT Bergman on 1/14/20.
//  Copyright © 2020 Joseph Bergman. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
public typealias PlatformImageType = UIImage

#elseif os(macOS)
import AppKit
public typealias PlatformImageType = NSImage
#endif
