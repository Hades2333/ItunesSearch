//
//  DetailViewController.swift
//  Search
//
//  Created by Hellizar on 23.07.21.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!

    // MARK: Properties

    var searchResult: SearchResult!
    var downloadTask: URLSessionDownloadTask?

    // MARK: Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.tintColor = UIColor(red: 20/255, green: 160/255,
                                 blue: 160/255, alpha: 1)
        popUpView.layer.cornerRadius = 10

        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)

        if searchResult != nil {
            updateUI()
        }
    }

    deinit {
        print("deinit \(self)")
        downloadTask?.cancel()
    }

    // MARK: Methods

    func updateUI() {
        nameLabel.text = searchResult.name
        if searchResult.artist.isEmpty {
            artistNameLabel.text = "Unknown"
        } else {
            artistNameLabel.text = searchResult.artist
        }
        kindLabel.text = searchResult.type
        genreLabel.text = searchResult.genre

        // Show price
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        let priceText: String
        if searchResult.price == 0 {
            priceText = "Free"
        } else if let text = formatter.string(
                    from: searchResult.price as NSNumber) {
            priceText = text
        } else {
            priceText = ""
        }
        priceButton.setTitle(priceText, for: .normal)

        if let largeURL = URL(string: searchResult.imageLarge) {
          downloadTask = artworkImageView.loadImage(url: largeURL)
        }
    }

    // MARK: Actions
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func openInStore() {
        if let url = URL(string: searchResult.storeURL) {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: nil)
        }
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension DetailViewController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: UIGestureRecognizerDelegate

extension DetailViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
