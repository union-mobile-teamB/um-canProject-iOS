//
//  Path+Extension.swift
//  UtilityPlugin
//
//  Created by 강현준 on 4/8/24.
//

import ProjectDescription

public extension Path {
    
    static var app: Self {
        return .relativeToRoot("Projects/AppModuls")
    }
    
    static var root: Self {
        return .relativeToRoot("Projects/Root")
    }
    
    static var baseInterface: Self {
        return .relativeToRoot("Projects/BaseInterface")
    }
    
    static var data: Self {
        return .relativeToRoot("Projects/Data")
    }
    
    static var networkKit: Self {
        return .relativeToRoot("Projects/NetworkKit")
    }
    
    static var domain: Self {
        return .relativeToRoot("Projects/Domain")
    }
    
    static var core: Self {
        return .relativeToRoot("Projects/Core")
    }
    
    static var thirdPartyLib: Self {
        return .relativeToRoot("Projects/ThirdPartyLib")
    }
    
    static var designKit: Self {
        return .relativeToRoot("Projects/DesignKit")
    }
    
}
