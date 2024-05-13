//
//  Target+Extension.swift
//  UtilityPlugin
//
//  Created by Junyoung on 3/10/24.
//

import Foundation
import ProjectDescription

public extension Target {
    static func makeTarget(
        name: String,
        product: Product,
        hasResource: Bool,
        bundleId: String,
        infoPlist: InfoPlist?,
        sources: SourceFilesList?,
        script: [TargetScript],
        dependencies: [TargetDependency],
        settings: Settings?
    ) -> Target {
        return .target(
            name: name,
            destinations: CommonEnviroment.destination,
            product: product,
            bundleId: bundleId,
            deploymentTargets: CommonEnviroment.deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: hasResource == true ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            scripts: script,
            dependencies: dependencies,
            settings: settings
        )
    }
}

public extension Target {
    enum CommonEnviroment {
        public static let bundlePrefix = "com.unmobile.App"
        public static let deploymentTarget = DeploymentTargets.iOS("14.0")
        public static let destination: Set<Destination> = [.iPhone, .iPad]
    }
}
