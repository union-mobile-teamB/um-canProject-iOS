//
//  InfoPlist.swift
//  UtilityPlugin
//
//  Created by 강현준 on 4/8/24.
//

import Foundation
import ProjectDescription

public extension Project {
    static let infoPlist: [String: Plist.Value] = [
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.unmobile.App",
        "CFBundleDisplayName": "unmobile",
        "UILaunchStoryboardName": "Launch Screen",
        "UIUserInterfaceStyle": "Light",
        "LSSupportsOpeningDocumentsInPlace": true,
        "ITSAppUsesNonExemptEncryption": false,
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ]
    ]
    
    static let devInfoPlist: [String: Plist.Value] = [
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.unmobile.App",
        "CFBundleDisplayName": "unmobile",
        "UILaunchStoryboardName": "Launch Screen",
        "UIUserInterfaceStyle": "Light",
        "LSSupportsOpeningDocumentsInPlace": true,
        "ITSAppUsesNonExemptEncryption": false,
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ]
    ]
    
    static func moduleInfoPlist(name: String, prefix: String) -> [String: Plist.Value] {
        [
            "CFBundleShortVersionString": "1.0.0",
            "CFBundleDevelopmentRegion": "ko",
            "CFBundleVersion": "1",
            "CFBundleIdentifier": "\(prefix).\(name)",
            "CFBundleDisplayName": "\(name)",
            "UILaunchStoryboardName": "Launch Screen",
            "UIUserInterfaceStyle": "Light",
            "LSSupportsOpeningDocumentsInPlace": true,
            "ITSAppUsesNonExemptEncryption": false,
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [
                        [
                            "UISceneConfigurationName": "Default Configuration",
                            "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                        ],
                    ]
                ]
            ]
        ]
    }
}
