//
//  ItemDetailInfoCoordinator.swift
//  DoorDash
//
//  Created by Marvin Zhan on 2018-10-05.
//  Copyright © 2018 Monster. All rights reserved.
//

import UIKit

final class ItemDetailInfoCoordinator: Coordinator {

    let router: Router
    var coordinators: [Coordinator] = []
    let rootViewController: ItemDetailInfoViewController

    init(rootViewController: ItemDetailInfoViewController,
         router: Router) {
        self.router = router
        self.rootViewController = rootViewController
    }

    func start() {
        self.rootViewController.delegate = self
        self.router.setRootModule(rootViewController, hideBar: true)
    }

    func toPresentable() -> UIViewController {
        return self.router.navigationController
    }
}

extension ItemDetailInfoCoordinator: ItemDetailInfoViewControllerDelegate {

    func dismiss() {
        self.router.dismissModule()
    }
}
