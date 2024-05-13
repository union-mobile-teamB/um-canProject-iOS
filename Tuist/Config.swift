//
//  Config.swift
//  ProjectDescriptionHelpers
//
//  Created by 강현준 on 4/8/24.
//

import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugin/UtilityPlugin"))
    ]
)
