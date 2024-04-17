//
//  QuotesVc.swift
//  Quotes APP
//
//  Created by AKASH BOGHANI on 13/04/24.
//

import UIKit

final class DetailVc: ViewController<DetailVm>{
    //MARK: - @IBOutlets
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceChange: UILabel!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCoinNameShort: UILabel!
    @IBOutlet weak var lblSupply: UILabel!
    @IBOutlet weak var lblMaxSupply: UILabel!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblVolumeWeighted: UILabel!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<DetailVm.Input>()
    var model: DataModel?
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DetailVm()
        bindViewModel()
    }
    
    override func setUi() {
        super.setUi()
        
        guard let model = model else { return }
        
        imgCoin.imageWith(latter: model.symbol ?? "ETH")
        lblPrice.text = model.priceUsd
        lblCoinName.text = model.name
        lblCoinNameShort.text = model.symbol
        lblPriceChange.text = model.changePercent24Hr
        lblSupply.text = model.supply
        lblMaxSupply.text = model.maxSupply ?? "No Data Available"
        lblVolume.text = model.volumeUsd24Hr
        lblVolumeWeighted.text = model.vwap24Hr
    }
    
    //MARK: - @IBActions
    @IBAction func onTapButtonLink(_ sender: Any) {
        guard let model = model, let url = URL(string: model.explorer ?? "") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        viewModel?.router.pop(with: nil, for: nil)
    }
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            }
        }.store(in: &disposeBag)
    }
}
