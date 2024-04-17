//
//  ProfileVc.swift
//  NewsApp
//
//  Created by AKASH BOGHANI on 10/04/24.
//

import UIKit

final class ProfileVc: ViewController<ProfileVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvProfile: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<ProfileVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileVm()
        bindViewModel()
        input.send(.makeCall)
    }
    
    override func setUi() {
        super.setUi()
        
        clvProfile.delegate = self
        clvProfile.dataSource = self
        clvProfile.register(R.nib.profileCell)
        clvProfile.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonBack(_ sender: Any) {
        viewModel?.router.pop(with: nil, for: nil)
    }
    
    //MARK: - Functions
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            AppLayout.shared.profileSection()
        }
        clvProfile.setCollectionViewLayout(layout, animated: true)
    }
    
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            case .getData:
                strongSelf.clvProfile.reloadSection(section: 1)
            }
        }.store(in: &disposeBag)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProfileVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return viewModel?.arrModel.count ?? 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileCell = clvProfile.deque(indexPath: indexPath)
            return cell
        case 1:
            let cell: DataCell = clvProfile.deque(indexPath: indexPath)
            cell.model = viewModel?.arrModel[indexPath.row]
            return cell
        default: return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            viewModel?.router.push(to: .detail(model: viewModel?.arrModel[indexPath.row]), with: nil, for: nil)
        default: break
        }
    }
}
