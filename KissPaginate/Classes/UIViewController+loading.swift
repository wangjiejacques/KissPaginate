//
//  UIViewController+loading.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

let activityTag = 99

extension UIViewController {

    private var rootView: UIView? {
        return view.window?.rootViewController?.view
    }

    // if view is nil, show activity in rootView.
    // don't show two activity indicator in one controller.
    func showActivityIndicator(inView view: UIView? = nil) {
        guard let activityParent = view ?? rootView else { return }
        guard activityParent.viewWithTag(activityTag) == nil else { return }
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.activityIndicatorViewStyle = .Gray
        activity.startAnimating()
        activity.tag = activityTag
        activityParent.addSubview(activity)
        let centerXConstraint = NSLayoutConstraint(item: activity, attribute: .CenterX, relatedBy: .Equal, toItem: activityParent, attribute: .CenterX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: activity, attribute: .CenterY, relatedBy: .Equal, toItem: activityParent, attribute: .CenterY, multiplier: 1, constant: 0)
        let widthEqual = NSLayoutConstraint(item: activity, attribute: .Width, relatedBy: .Equal, toItem: activityParent, attribute: .Width, multiplier: 1, constant: 0)
        let heightEqual = NSLayoutConstraint(item: activity, attribute: .Height, relatedBy: .Equal, toItem: activityParent, attribute: .Height, multiplier: 1, constant: 0)
        activityParent.addConstraints([centerXConstraint, centerYConstraint, widthEqual, heightEqual])
        activity.layoutMargins = UIEdgeInsetsZero
    }

    func hideActivityIndicator(inView view: UIView? = nil) {
        guard let activityParent = view ?? rootView else { return }
        activityParent.viewWithTag(activityTag)?.removeFromSuperview()
    }
}
