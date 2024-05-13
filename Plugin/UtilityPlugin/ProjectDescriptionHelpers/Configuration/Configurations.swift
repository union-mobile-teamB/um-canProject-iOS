//
//  Configurations.swift
//  UtilityPlugin
//
//  Created by 강현준 on 4/8/24.
//

import Foundation
import ProjectDescription

public struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path { .relativeToRoot("xcconfigs/targets/iOS-Framework.xcconfig") }
        
        static func project(_ config: String) -> ProjectDescription.Path { .relativeToRoot("xcconfigs/Base/Projects/Project-\(config).xcconfig") }
    }
    
    public static let framework: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.framework),
        .release(name: "PROD", xcconfig: Path.framework),
    ]
    
    public static let project: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.project("DEV")),
        .release(name: "PROD", xcconfig: Path.project("PROD")),
    ]
}
