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
    @IBOutlet weak var switchAnnotation: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var dataGlobal = [CovidCountryModel]()
    private var annotations = [MKPointAnnotation]()

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
                let coordinate = CLLocationCoordinate2D(latitude: item.countryInfo.lat, longitude: item.countryInfo.long)

                let annotation = PointAnnotationModel()
                annotation.data = item
                annotation.title = item.country
                annotation.subtitle = "Jumlah kasus: \(item.cases.toCommaSeperated())"
                annotation.coordinate = coordinate
                self.annotations.append(annotation)
                self.mapView.addAnnotation(annotation)

                let overlay = MKCircle(center: coordinate, radius: self.overlayRadius(cases: item.cases))
                self.mapView.addOverlay(overlay)
            }

            self.activityIndicator.isHidden = true
        }
    }

    private func overlayRadius(cases: Int) -> CLLocationDistance {
        switch cases {
        case 50000..<250000:
            return 150000
        case 17000..<50000:
            return 125000
        case 3000..<17000:
            return 100000
        case 1600..<3000:
            return 87500
        case 800..<1600:
            return 75000
        case 400..<800:
            return 67500
        case 200..<400:
            return 50000
        case 50..<200:
            return 37500
        case 10..<50:
            return 25000
        default:
            return 15000
        }
    }

    @IBAction func switchChanged(_ sender: Any) {
        if switchAnnotation.isOn {
            mapView.addAnnotations(annotations)
        } else {
            mapView.removeAnnotations(annotations)
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

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let overlay = overlay as? MKCircle else {return MKOverlayRenderer()}
        let circleRenderer = MKCircleRenderer(circle: overlay)
        circleRenderer.fillColor = .systemOrange
        circleRenderer.strokeColor = .clear
        circleRenderer.alpha = 0.7
        return circleRenderer
    }
}
