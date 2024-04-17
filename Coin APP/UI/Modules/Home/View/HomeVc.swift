//
//  HomeVc.swift
//  NewsApp
//
//  Created by AKASH BOGHANI on 10/04/24.
//

import UIKit

final class HomeVc: ViewController<HomeVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvHome: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<HomeVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeVm()
        bindViewModel()
        input.send(.makeCall)
    }
    
    override func setUi() {
        super.setUi()
        
        clvHome.delegate = self
        clvHome.dataSource = self
        clvHome.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonSetting(_ sender: Any) {
        viewModel?.router.push(to: .profile, with: nil, for: nil)
    }
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            case .getData:
                strongSelf.clvHome.reload()
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return AppLayout.shared.profileSection()
        }
        clvHome.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.arrModel.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DataCell = clvHome.deque(indexPath: indexPath)
        cell.model = viewModel?.arrModel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.router.push(to: .detail(model: viewModel?.arrModel[indexPath.row]), with: nil, for: nil)
    }
}
