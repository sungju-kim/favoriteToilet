//
//  ContextProvider.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/18.
//

import Foundation
import AuthenticationServices

final class ContextProvider: NSObject, ASAuthorizationControllerPresentationContextProviding {
    private var window: UIWindow?
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = window else { return ASPresentationAnchor() }
        return window
    }

    convenience init(window: UIWindow?) {
        self.init()
        self.window = window
    }
}
