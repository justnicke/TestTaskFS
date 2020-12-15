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
        let navigationController = NavigationController(rootViewController: AlbumViewController())
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            let titleFontAttrs = [
                NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 25)!,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = titleFontAttrs
            appearance.configureWithOpaqueBackground()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9713452483)
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
        return navigationController
    }
}

final class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
