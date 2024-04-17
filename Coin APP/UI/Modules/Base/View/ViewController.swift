//
//  ViewController.swift
//  KarmaScore
//
//  Created by AKASH on 07/11/23.
//

import UIKit

class ViewController<T: ViewModel>: UIViewController {
    // MARK: - @IBOutlet
    var viewModel: T?

    // MARK: - Properties

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUi()
    }

    // MARK: - @IBAction

    // MARK: - Functions
    func setUi() {
        navigationController?.navigationBar.isHidden = true
    }
}
