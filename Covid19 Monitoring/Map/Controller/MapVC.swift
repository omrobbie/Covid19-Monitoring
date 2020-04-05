//
//  MapVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 05/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var dataGlobal = [CovidCountryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        loadData()
    }

    private func setupDelegate() {
        mapView.delegate = self
    }

    private func loadData() {
        ApiService.shared.getDataGlobalPerCountry { (data) in
            data.forEach { (item) in
                let annotation = PointAnnotationModel()
                annotation.data = item
                annotation.title = item.country
                annotation.subtitle = "Jumlah kasus: \(item.cases.toCommaSeperated())"
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.countryInfo.lat, longitude: item.countryInfo.long)
                self.mapView.addAnnotation(annotation)
            }

            self.activityIndicator.isHidden = true
        }
    }
}

extension MapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        annotationView.isEnabled = true
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PointAnnotationModel else {return}
        let vc = UIStoryboard(name: "Global", bundle: nil).instantiateViewController(identifier: "GlobalDetailVC") as! GlobalDetailVC
        vc.modalPresentationStyle = .popover
        vc.data = annotation.data
        present(vc, animated: true, completion: nil)
    }
}
