//
//  AlertMessage.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 04/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

enum alertType: String {
    case none = ""
    case information = "Informasi"
    case question = "Pertanyaan"
    case warning = "Perhatian!"
    case error = "Pesan "
}

func alertMessage(sender: UIViewController, message: String, type: alertType, title: String = "", preferredStyle: UIAlertController.Style = .alert, withCancel: Bool = false, completion: ((Bool) -> ())?) {
    var header = title

    if type != .none {
        header = type.rawValue

        if !title.isEmpty {
            header = "\(header) - \(title)"
        }
    }

    let alertVC = UIAlertController(title: header, message: message, preferredStyle: preferredStyle)
    let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
    let actionCancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)

    let actionYes = UIAlertAction(title: "Iya", style: .default) { (_) in
        if let completion = completion {
            completion(true)
        }
    }

    let actionNo = UIAlertAction(title: "Tidak", style: .destructive) { (_) in
        if let completion = completion {
            completion(false)
        }
    }

    switch type {
    case .question:
        alertVC.addAction(actionYes)
        alertVC.addAction(actionNo)
    default:
        alertVC.addAction(actionOk)
    }

    if withCancel {
        alertVC.addAction(actionCancel)
    }

    sender.present(alertVC, animated: true, completion: nil)
}
