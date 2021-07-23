//
//  DimmingPresentationController.swift
//  Search
//
//  Created by Hellizar on 23.07.21.
//

import UIKit

class DimmingPresentationController: UIPresentationController {

    // MARK: IBOutlets

    override var shouldRemovePresentersView: Bool {
        return false
    }

    // MARK: GUI variables

    lazy var dimmingView = GradientView(frame: CGRect.zero)

    // MARK: Methods

    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)

        dimmingView.alpha = 0
        if let coordinator =
            presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
            }, completion: nil)
        }
    }

    override func dismissalTransitionWillBegin()  {
        if let coordinator =
            presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
}
