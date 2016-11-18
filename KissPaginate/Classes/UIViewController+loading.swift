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

    fileprivate var rootView: UIView? {
        return view.window?.rootViewController?.view
    }

    // if view is nil, show activity in rootView.
    // don't show two activity indicator in one controller.
    func showActivityIndicator(inView view: UIView? = nil) {
        guard let activityParent = view ?? rootView else { return }
        guard activityParent.viewWithTag(activityTag) == nil else { return }
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.activityIndicatorViewStyle = .gray
        activity.backgroundColor = UIColor.white
        activity.startAnimating()
        activity.tag = activityTag
        activityParent.addSubview(activity)
        let centerXConstraint = NSLayoutConstraint(item: activity, attribute: .centerX, relatedBy: .equal, toItem: activityParent, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: activity, attribute: .centerY, relatedBy: .equal, toItem: activityParent, attribute: .centerY, multiplier: 1, constant: 0)
        let widthEqual = NSLayoutConstraint(item: activity, attribute: .width, relatedBy: .equal, toItem: activityParent, attribute: .width, multiplier: 1, constant: 0)
        let heightEqual = NSLayoutConstraint(item: activity, attribute: .height, relatedBy: .equal, toItem: activityParent, attribute: .height, multiplier: 1, constant: 0)
        activityParent.addConstraints([centerXConstraint, centerYConstraint, widthEqual, heightEqual])
        activity.layoutMargins = UIEdgeInsets.zero
    }

    func hideActivityIndicator(inView view: UIView? = nil) {
        guard let activityParent = view ?? rootView else { return }
        activityParent.viewWithTag(activityTag)?.removeFromSuperview()
    }
}
