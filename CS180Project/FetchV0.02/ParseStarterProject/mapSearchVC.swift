//
//  mapSearchVC.swift
//  Fetch
//
//  Created by Jonathan Tan on 3/21/16.
//  Copyright © 2016 Jonathan Tan. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Parse

protocol HandleMapSearch {
    func newLocationZoomIn(placemark:MKPlacemark)
}

class mapSearchVC: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate, UISearchBarDelegate, UISearchControllerDelegate {
    
    //*
    // Constants
    //*
    var geoCoder: CLGeocoder?
    let locationManager = CLLocationManager()
    var previousAddress: String?
    var activeUser: User!
    var resultSearchController:UISearchController? = nil
    var searchBar: UISearchBar?
    var selectedPin:MKPlacemark? = nil
    var didChangeView = false
    var returnedFromMenu = false
    var returnedAddress: String?
    
    //*
    // Outlets
    //*
    @IBOutlet weak var Open: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var fetchAction: UIButton!
    @IBOutlet weak var embeddedJobTitleLabel: UILabel!
    @IBOutlet weak var embeddedJobIdLabel: UILabel!
    @IBOutlet weak var embeddedCountdownLabel: UILabel!
    @IBOutlet weak var embeddedNameLabel: UILabel!
    @IBOutlet weak var embeddedAddressLabel: UILabel!
    @IBOutlet weak var embeddedDescriptionText: UITextView!
    @IBOutlet weak var embeddedPayLabel: UILabel!
    @IBOutlet weak var embeddedView: UIView!
    @IBOutlet weak var switchViewControl: UISegmentedControl!

    //*
    // Actions
    //*
    @IBAction func fetchDidTouch(sender: AnyObject) {
        //
    }
    
    @IBAction func resetMapDidTouch(sender: AnyObject) {
                mapView.setCenterCoordinate(mapView.userLocation.coordinate, animated: true)
    }
    
    @IBAction func embeddedApplyDidTouch(sender: AnyObject) {
    }
    
    @IBAction func embeddedCancelDidTouch(sender: AnyObject) {
        embeddedView.hidden = true
    }
    
    @IBAction func switchViewDidTouch(sender: AnyObject) {
        switch switchViewControl.selectedSegmentIndex
            {
            case 0:
                print("Switch to business")
            case 1:
                print("Switch to mode")
            default:
                break;
        }
    }
    
    //*
    // Custom functions
    //*
    
//    func saveUserLocation() {
//        PFGeoPoint.geoPointForCurrentLocationInBackground {
//            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
//            if error == nil {
//                let query = PFUser.query()
//                query?.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!,
//                    block: { (location: PFObject?, error: NSError?) -> Void in
//                        location!["location"] = geoPoint
//                        location!.saveInBackground()
//                })
//            } else {
//                print("Could not determine your location. Please try again later.")
//            }
//        }
//    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        self.mapView!.centerCoordinate = location.coordinate
        let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500, 1500)
        self.mapView!.setRegion(reg, animated: true)
        geoCode(location)
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animate: Bool) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geoCode(location)
    }
    
    // Function to set annotations on map
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if !(annotation is customMapPin) {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.purpleColor()
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "annotationInfoIcon"), forState: .Normal)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    // Functions for what happens if annotations are pressed
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let annotation = view.annotation as? customMapPin {
            print(annotation.jobID!)
            var query = PFQuery(className:"jobRequest")
            var parseTitle: String = ""
            var parseAddress: String = ""
            var parsePay: String = ""
            var parseDescription: String = ""
            query.whereKey("objectId", equalTo:(annotation.jobID!))
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let object: PFObject = objects?[0] {
                        // Create the alert controller
                        print(object.createdAt!)
                        parseAddress = object["jobAddress"] as! String
                        parseTitle = object["jobTitle"] as! String
                        parsePay = object["jobPayment"] as! String
                        parseDescription = object["jobDescription"] as! String //.trunc(50, parsePay: parsePay)
                        //
                        var updatedAt: NSDate = object.updatedAt!
                        var dateFormat: NSDateFormatter = NSDateFormatter()
                        
                        //
                        
                        let calendar = NSCalendar.currentCalendar()
                        let comp = calendar.components([.Month, .Day, .Hour, .Minute, .Second], fromDate: updatedAt)
                        let month = comp.month
                        let day = comp.day
                        let hour = comp.hour
                        let minute = comp.minute
                        let second = comp.second
                        
                        print("Month:\(month)")
                        print("Day:\(day)")
                        print("Hour:\(hour)")
                        print("Minute:\(minute)")
                        print("Second:\(second)")
                        
                        //
                        print("UpdatedAt:\(updatedAt)")
                        self.embeddedView.hidden = false
                        self.embeddedJobTitleLabel.text = parseTitle
                        self.embeddedAddressLabel.text = parseAddress
                        self.embeddedDescriptionText.text = parseDescription
                        self.embeddedPayLabel.text = parsePay
                        self.embeddedJobIdLabel.text = annotation.jobID!
                    }
                } else {
                    print(error)
                }
            }
        }
    }
    
    // Function to open Apple map directions
    func getDirections() {
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMapsWithLaunchOptions(launchOptions)
        }
    }
    
    func geoCode(location : CLLocation!) {
        geoCoder!.cancelGeocode()
        geoCoder!.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else {
                return
            }
            let loc: CLPlacemark = placeMarks[0]
            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString:NSObject]
            let addrList = addressDict["FormattedAddressLines"] as! [String]
            let address = addrList.joinWithSeparator(", ")
            print(address)
            self.previousAddress = address
            self.activeUser.currentLocation = address
            self.searchBar!.text = address
        })
    }

    // Reset searchBar text is dismissed to previousAddress
    func didDismissSearchController(searchController: UISearchController) {
        print("Search bar was dismissed.")
        self.searchBar!.text = previousAddress
    }
    
    //*
    // Overrided functions
    //*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set activeUser information
        activeUser = User()
        
        // Setup embedded view
        embeddedView.hidden = true

        // Load menu
        Open.action = Selector("revealToggle:")
        
        // Load Map
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        geoCoder = CLGeocoder()
        self.mapView!.delegate = self
        
        // Setup location search results table
        let LocationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("locationSearchTable") as! locationSearchTable
        resultSearchController = UISearchController(searchResultsController: LocationSearchTable)
        resultSearchController?.searchResultsUpdater = LocationSearchTable
        resultSearchController?.delegate = self
        
        // Setup search bar
        searchBar = resultSearchController!.searchBar
        searchBar!.sizeToFit()
        self.searchBar!.delegate = self
        searchBar!.tintColor = UIColor(white: 0.3, alpha: 1.0)
        self.searchBar!.placeholder = "Enter job location"
        self.searchBar!.text = previousAddress
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        // Search for locations using MKLocalSearchRequest
        LocationSearchTable.mapView = mapView
        LocationSearchTable.handleMapSearchDelegate = self
        
        // Place annotations on map where jobs exist
        var query = PFQuery(className:"jobRequest")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for object in objects! {
                    var parseAddress = object["jobAddress"] as! String
                    var parseTitle = object["jobTitle"] as! String
                    var parsePay = object["jobPayment"] as! String
                    var parseJobID = object.objectId as! String?
                    var parseDescription = (object["jobDescription"] as! String) //.trunc(50, parsePay: parsePay)
                    
                    CLGeocoder().geocodeAddressString(parseAddress,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                        if (placemarks?.count > 0) {
                            var topResult: CLPlacemark = (placemarks?[0])!
                            var placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                            var region: MKCoordinateRegion = self.mapView.region
                            region.center.latitude = (placemark.location?.coordinate.latitude)!
                            region.center.longitude = (placemark.location?.coordinate.longitude)!
                            region.span.longitudeDelta /= 8.0
                            region.span.latitudeDelta /= 8.0
                            
                            let annotation = customMapPin(coordinate: (placemark.location?.coordinate)!, title: parseTitle, subtitle: parseDescription, jobID: parseJobID!)
                            self.mapView.addAnnotation(annotation)
//                            let annotation = MKPointAnnotation()
//                            annotation.coordinate = (placemark.location?.coordinate)!
//                            annotation.title = parseTitle
//                            annotation.subtitle = parseSubject
//                            self.mapView.addAnnotation(annotation)
                        }
                    })
                    print(parseAddress)
                }
            } else {
                print(error)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        Open.action = Selector("revealToggle:")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "requestJobMenuSegue") {
            //get a reference to the destination view controller
            let destinationVC:requestMenuVC = segue.destinationViewController as! requestMenuVC
            destinationVC.activeUser = activeUser
            destinationVC.currentAddress = searchBar!.text
        }
    }
}

extension mapSearchVC: HandleMapSearch {
    func newLocationZoomIn(placemark:MKPlacemark){
        selectedPin = placemark
        self.mapView!.centerCoordinate = placemark.coordinate
        let reg = MKCoordinateRegionMakeWithDistance(placemark.coordinate, 1500, 1500)
        self.mapView!.setRegion(reg, animated: true)
    }
}

extension String {
    func trunc(length: Int, parsePay: String) -> String {
        var trailing: String? = "... for \(parsePay)"
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self + (trailing ?? "")
        }
    }
}

class customMapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var jobID: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, jobID: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.jobID = jobID
    }
    
}

