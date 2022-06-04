//
//  Annotation.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 02.06.2022.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
    let xid: String
    
    init(
      title: String?,
      locationName: String?,
      discipline: String?,
      coordinate: CLLocationCoordinate2D,
      xid: String
    ) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.xid = xid
        super.init()
    }
    
    var subtitle: String? {
      return locationName
    }
    
    enum Disciplines {
        case interesting_places
        case cultural
        
    }
    
    var image: UIImage {
        guard let name = discipline else {
            return UIImage(named: "arch")!
        }
        if name.contains("interesting_places") {
            if name.contains("architecture") {
                return UIImage(named: "pinArch")!
            } else if name.contains("historic") {
                return UIImage(named: "pinHistorical")!
            } else if name.contains("industrial_facilities") {
                return UIImage(named: "pinIndust")!
            } else if name.contains("natural") {
                return UIImage(named: "pinNature")!
            } else if name.contains("cultural") {
                return UIImage(named: "pinCulture")!
            } else if name.contains("religion") {
                return UIImage(named: "pinReligion")!
            } else if name.contains("other") {
                return UIImage(named: "pinOther")!
            }
        } else if name.contains("tourist_facilities") {
            if name.contains("banks") {
                return UIImage(named: "pinBank")!
            } else if name.contains("foods") {
                return UIImage(named: "pinFoods")!
            } else if name.contains("shops") {
                return UIImage(named: "pinShop")!
            } else if name.contains("transport") {
                return UIImage(named: "pinTransport")!
            }
        } else if name.contains("amusements") {
            if name.contains("amusement_parks") {
                return UIImage(named: "pinPark")!
            } else if name.contains("ferris_wheels") {
                return UIImage(named: "pinWheel")!
            } else if name.contains("miniature_parks") {
                return UIImage(named: "pinMiniPark")!
            } else if name.contains("roller_coasters") {
                return UIImage(named: "pinRoller")!
            } else if name.contains("water_parks") {
                return UIImage(named: "pinWaterPark")!
            }
        } else if name.contains("accomodations") {
            if name.contains("apartments") {
                return UIImage(named: "pinApartment")!
            } else if name.contains("other_hotels") {
                return UIImage(named: "pinHotel")!
            } else if name.contains("hostels") {
                return UIImage(named: "pinHostel")!
            } else if name.contains("resorts") {
                return UIImage(named: "pinResort")!
            } else if name.contains("villas_and_chalet") {
                return UIImage(named: "pinVillas")!
            }
        } else if name.contains("sport") {
            if name.contains("pools") {
                return UIImage(named: "pinPool")!
            } else if name.contains("stadiums") {
                return UIImage(named: "pinStadium")!
            } else if name.contains("winter_sports") {
                return UIImage(named: "pinWinter")!
            } else if name.contains("climbing") {
                return UIImage(named: "pinClimb")!
            } else if name.contains("diving") {
                return UIImage(named: "pinDiving")!
            } else if name.contains("kitesurfing") {
                return UIImage(named: "pinKite")!
            } else if name.contains("surfing") {
                return UIImage(named: "pinSurf")!
            }
        }  else if name.contains("adult") {
            if name.contains("alcohol") {
                return UIImage(named: "pinAlcohol")!
            } else if name.contains("casino") {
                return UIImage(named: "pinCasino")!
            } else if name.contains("hookah") {
                return UIImage(named: "pinHookah")!
            } else if name.contains("nightclubs") {
                return UIImage(named: "pinNight")!
            }
        }
        return UIImage(named: "pinOther")!
    }
}

class AnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Annotation else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            image = artwork.image
            markerTintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0,alpha:0.5).withAlphaComponent(0)
            glyphTintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0,alpha:0.5).withAlphaComponent(0)
        }
    }
}
