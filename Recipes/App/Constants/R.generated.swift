//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
    fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
    fileprivate static let hostingBundle = Bundle(for: R.Class.self)
    
    static func validate() throws {
        try intern.validate()
    }
    
    /// This `R.color` struct is generated, and contains static references to 0 colors.
    struct color {
        fileprivate init() {}
    }
    
    /// This `R.file` struct is generated, and contains static references to 0 files.
    struct file {
        fileprivate init() {}
    }
    
    /// This `R.font` struct is generated, and contains static references to 0 fonts.
    struct font {
        fileprivate init() {}
    }
    
    /// This `R.image` struct is generated, and contains static references to 3 images.
    struct image {
        /// Image `launchImage`.
        static let launchImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "launchImage")
        /// Image `notFound`.
        static let notFound = Rswift.ImageResource(bundle: R.hostingBundle, name: "notFound")
        /// Image `recipePlaceholder`.
        static let recipePlaceholder = Rswift.ImageResource(bundle: R.hostingBundle, name: "recipePlaceholder")
        
        /// `UIImage(named: "launchImage", bundle: ..., traitCollection: ...)`
        static func launchImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
            return UIKit.UIImage(resource: R.image.launchImage, compatibleWith: traitCollection)
        }
        
        /// `UIImage(named: "notFound", bundle: ..., traitCollection: ...)`
        static func notFound(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
            return UIKit.UIImage(resource: R.image.notFound, compatibleWith: traitCollection)
        }
        
        /// `UIImage(named: "recipePlaceholder", bundle: ..., traitCollection: ...)`
        static func recipePlaceholder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
            return UIKit.UIImage(resource: R.image.recipePlaceholder, compatibleWith: traitCollection)
        }
        
        fileprivate init() {}
    }
    
    /// This `R.nib` struct is generated, and contains static references to 0 nibs.
    struct nib {
        fileprivate init() {}
    }
    
    /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
    struct reuseIdentifier {
        fileprivate init() {}
    }
    
    /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
    struct segue {
        fileprivate init() {}
    }
    
    /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
    struct storyboard {
        /// Storyboard `LaunchScreen`.
        static let launchScreen = _R.storyboard.launchScreen()
        
        /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
        static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
            return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
        }
        
        fileprivate init() {}
    }
    
    /// This `R.string` struct is generated, and contains static references to 0 localization tables.
    struct string {
        fileprivate init() {}
    }
    
    fileprivate struct intern: Rswift.Validatable {
        fileprivate static func validate() throws {
            try _R.validate()
        }
        
        fileprivate init() {}
    }
    
    fileprivate class Class {}
    
    fileprivate init() {}
}

struct _R: Rswift.Validatable {
    static func validate() throws {
        try storyboard.validate()
    }
    
    struct nib {
        fileprivate init() {}
    }
    
    struct storyboard: Rswift.Validatable {
        static func validate() throws {
            try launchScreen.validate()
        }
        
        struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
            typealias InitialController = UIKit.UIViewController
            
            let bundle = R.hostingBundle
            let name = "LaunchScreen"
            
            static func validate() throws {
                if UIKit.UIImage(named: "launchImage") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'launchImage' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
            }
            
            fileprivate init() {}
        }
        
        fileprivate init() {}
    }
    
    fileprivate init() {}
}
