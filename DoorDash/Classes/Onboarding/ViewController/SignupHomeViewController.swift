//
//  SignupHomeViewController.swift
//  DoorDash
//
//  Created by Marvin Zhan on 2018-09-16.
//  Copyright © 2018 Monster. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class SignupHomeViewController: BaseViewController {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    private let customNavigationBar: SignupHomeNavigationBar
    private let collectionView: UICollectionView
    private let viewModel: SignupHomeViewModel

    private let inputSectionController: SignInputFormSectionController

    var mode: SignupMode

    init(mode: SignupMode) {
        self.mode = mode
        inputSectionController = SignInputFormSectionController()
        viewModel = SignupHomeViewModel(
            userAPI: UserAPIService(),
            dataStore: ApplicationEnvironment.current.dataStore
        )
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        customNavigationBar = SignupHomeNavigationBar(mode: mode)
        super.init()
        adapter.dataSource = self
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SignupHomeViewController {

    private func setupUI() {
        self.view.backgroundColor = theme.colors.backgroundGray
        setupNavigationBar()
        setupCollectionView()
        setupConstraints()
    }

    private func setupNavigationBar() {
        self.view.addSubview(customNavigationBar)
        customNavigationBar.delegate = self
    }

    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        adapter.collectionView = collectionView
        collectionView.backgroundColor = theme.colors.backgroundGray
        collectionView.alwaysBounceVertical = true
    }

    private func setupConstraints() {
        customNavigationBar.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(theme.navigationBarHeight)
        }

        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SignupHomeViewController: ListAdapterDataSource {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.getDataSource(mode: mode)
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let text = object as? String, text == SignupHomeViewModel.socailLoginIdentifier {
            return SocialLoginSectionController()
        } else if object is SignupAgreementModel {
            return SignupAgreementSectionController()
        } else if object is SignupButtonModel {
            var inset: UIEdgeInsets = .zero
            if mode == .login {
                inset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
            }
            return SignupButtonSectionController(inset: inset, buttonTapped: signButtonTapped)
        }
        return inputSectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension SignupHomeViewController {
    func signButtonTapped() {
        if self.mode == .register {
            print(inputSectionController.inputResults)
        } else {

        }
    }
}

extension SignupHomeViewController: SignupHomeNavigationBarDelegate {
    func userSwitched(mode: SignupMode) {
        self.mode = mode
        self.adapter.performUpdates(animated: false)
    }
}
