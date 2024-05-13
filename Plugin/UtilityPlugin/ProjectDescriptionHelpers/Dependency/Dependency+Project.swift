//
//  Dependency+Project.swift
//  UtilityPlugin
//
//  Created by 강현준 on 4/8/24.
//

import ProjectDescription

public typealias Dep = TargetDependency

public extension Dep {
    static let root = Dep.project(target: "Root", path: .root)
    static let baseInterface = Dep.project(target: "BaseInterface", path: .baseInterface)
    static let data = Dep.project(target: "Data", path: .data)
    static let networkKit = Dep.project(target: "NetworkKit", path: .networkKit)
    static let domain = Dep.project(target: "Domain", path: .domain)
    static let core = Dep.project(target: "Core", path: .core)
    static let thirdPartyLib = Dep.project(target: "ThirdPartyLib", path: .thirdPartyLib)
    static let designKit = Dep.project(target: "DesignKit", path: .designKit)
}
