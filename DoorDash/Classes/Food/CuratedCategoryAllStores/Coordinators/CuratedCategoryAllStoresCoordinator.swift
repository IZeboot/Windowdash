//
//  CuratedCategoryAllStoresCoordinator.swift
//  DoorDash
//
//  Created by Marvin Zhan on 9/28/18.
//  Copyright © 2018 Monster. All rights reserved.
//

import UIKit

final class CuratedCategoryAllStoresCoordinator: Coordinator {

    let router: Router
    var coordinators: [Coordinator] = []
    let rootViewController: CuratedCategoryAllStoresViewController

    init(rootViewController: CuratedCategoryAllStoresViewController,
         router: Router) {
        self.router = router
        self.rootViewController = rootViewController
    }

    func start() {

    }

    func toPresentable() -> UIViewController {
        return self.rootViewController
    }
}

