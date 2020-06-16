//
//  AppCoordinator.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func start(with coordinator: Coordinator)
    var parentCoordinator: Coordinator? { get set }
    func didFinish(coordinator: Coordinator)
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // Must ovverride
    }
    
    func start(with coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let child = self.childCoordinators.firstIndex(where: {$0 === coordinator}) {
            self.childCoordinators.remove(at: child)
        }
    }
}
