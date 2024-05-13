//
//  module.swift
//  ProjectDescriptionHelpers
//
//  Created by 강현준 on 4/8/24.
//

import ProjectDescription

// command line 입력
// ex) tuist scaffold module --name "모듈명"

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Make MicroFeature Module",
    attributes: [nameAttribute],
    items: [
        // MARK: - Project.swift
        .file(path: "Projects/Features/\(nameAttribute)/Project.swift",
              templatePath: "stencil/project.stencil"),
        
        // MARK: - Sources
        .file(path: "Projects/Features/\(nameAttribute)/Sources/empty.swift",
              templatePath: "stencil/emptyFile.stencil"),
        
        // MARK: - Example(Demo)
        .file(path: "Projects/Features/\(nameAttribute)/Demo/Sources/AppDelegate.swift",
              templatePath: "stencil/appDelegate.stencil"),
        .file(path: "Projects/Features/\(nameAttribute)/Demo/Sources/SceneDelegate.swift",
              templatePath: "stencil/sceneDelegate.stencil"),
        
        // MARK: - Tests
        .file(path: "Projects/Features/\(nameAttribute)/Tests/Sources/empty.swift",
              templatePath: "stencil/emptyFile.stencil"),
        
        // MARK: - Interface
        .file(path: "Projects/Features/\(nameAttribute)/Interface/Sources/empty.swift",
              templatePath: "stencil/emptyFile.stencil")
    ]
)
