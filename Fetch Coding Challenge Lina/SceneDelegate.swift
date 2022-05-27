//
//  SceneDelegate.swift
//  Fetch Coding Challenge Lina
//
//  Created by Lina on 5/24/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        //programmatically setup app with Scene Delegate, add UINavigationController, set root ViewController, and create window hierarchy
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let viewController = CategoryViewController()
   //     let viewController = DetailViewController()
        let navigation = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()


    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

