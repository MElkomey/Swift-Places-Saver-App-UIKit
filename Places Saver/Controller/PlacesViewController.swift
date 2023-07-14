//
//  PlacesViewController.swift
//  Places Saver
//
//  Created by Mohamed Elkomey on 11/07/2023.
//

import UIKit
import RealmSwift
import CoreLocation
import MapKit

class PlacesViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "PlaceTableViewCell", bundle: nil), forCellReuseIdentifier: "placeCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        let landmarks = realm.objects(Landmark.self)
        Places.shared.landmarks = landmarks
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
        print(Places.shared.landmarks)
        
   //     print(Realm.Configuration.defaultConfiguration.fileURL)
    }

}

extension PlacesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Places.shared.landmarks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
        cell.name.text = Places.shared.landmarks[indexPath.row].name
        cell.time.text = DateFormatter.localizedString(from: Places.shared.landmarks[indexPath.row].time, dateStyle: .short, timeStyle: .short)
        cell.descreption.text = Places.shared.landmarks[indexPath.row].descreption
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! realm.write{
            realm.delete(Places.shared.landmarks[indexPath.row])
            tableView.reloadData()
        }
    }
}

extension PlacesViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("row selected")
        let latitude:CLLocationDegrees =  Places.shared.landmarks[indexPath.row].Latitude
                let longitude:CLLocationDegrees =  Places.shared.landmarks[indexPath.row].longitude
                let regionDistance:CLLocationDistance = 10000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                ]
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.openInMaps(launchOptions: options)
    }
}
