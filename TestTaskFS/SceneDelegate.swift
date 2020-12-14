//
//  SceneDelegate.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 10.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - Methods

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootVC()
        window?.makeKeyAndVisible()
    }
    
    private func rootVC() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: AlbumViewController())
        let appearance = UINavigationBarAppearance()
        let titleFontAttrs = [
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = titleFontAttrs
        navigationController.navigationBar.standardAppearance = appearance
        
        return navigationController
    }
}
