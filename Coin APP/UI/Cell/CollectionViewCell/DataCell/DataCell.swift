

import UIKit

final class DataCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceChange: UILabel!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCoinNameShort: UILabel!
    
    //MARK: - Properties
    var model: DataModel? {
        didSet {
            loadData()
        }
    }
    
    //MARK: - Life-Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - @IBActions
    @IBAction func onTapButtonLink(_ sender: Any) {
        guard let model = model, let url = URL(string: model.explorer ?? "") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    //MARK: - Functions
    private func loadData() {
        guard let model = model else { return }
        
        lblPrice.text = model.priceUsd
        lblCoinName.text = model.name
        lblCoinNameShort.text = model.symbol
        lblPriceChange.text = model.changePercent24Hr
        imgCoin.imageWith(latter: model.symbol ?? "ETH")
    }
}
