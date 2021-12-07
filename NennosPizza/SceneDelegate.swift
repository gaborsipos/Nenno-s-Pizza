//
//  SceneDelegate.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let homeVC = coreAssembler.resolveHomeViewController()
        let navigationController = UINavigationController(rootViewController: homeVC.viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
