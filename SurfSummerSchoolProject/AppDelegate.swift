//
//  AppDelegate.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 03.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tokenStorage: TokenStorage {
        BasetokenStorage()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        goToMain()
        
        startApplcationProcces()
        
        return true
    }
    
    func startApplcationProcces() {
        runLaunchScreen()
        
        if let tokenConteiner = try? tokenStorage.getToken(), !tokenConteiner.isExpired {
            goToMain()
        } else {
            let tempCredentials = AuthRequestModel(phone: "+79876543219", password: "qwerty")
            AuthService()
                .performLoginRequestAndSaveToken(credentials: tempCredentials) { result in
                    switch result {
                    case .success:
                        self.goToMain()
                    case .failure:
                        // TODO: - Hundle error, if token was not received
                        break
                    }
                }
        }
    }
    
    func goToMain() {
        DispatchQueue.main.async {
            self.window?.rootViewController = TabBarConfigurator().configur()
        }
    }
    
    func runLaunchScreen() {
        let launchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main)
            .instantiateInitialViewController()
        
        window?.rootViewController = launchScreenViewController
    }
}

