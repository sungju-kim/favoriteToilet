//
//  SignInDelegate.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/18.
//

import Foundation
import AuthenticationServices
import RxRelay

final class SignInDelegate: NSObject, ASAuthorizationControllerDelegate {

    let didLoadUserID = PublishRelay<String>()

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            didLoadUserID.accept(appleIDCredential.user)
        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
