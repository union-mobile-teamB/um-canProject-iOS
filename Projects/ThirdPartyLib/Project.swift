//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강현준 on 4/8/24.
//

import ProjectDescriptionHelpers
import ProjectDescription
import UtilityPlugin

let project = Project.makeModule(
    name: "ThirdPartyLib",
    targets: [.dynamicFramework],
    externalDependencies: [
        .SPM.Moya,
    ]
)
