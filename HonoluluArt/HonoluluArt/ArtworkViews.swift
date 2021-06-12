//
//  ArtworkViews.swift
//  HonoluluArt
//
//  Created by KPUGAME on 2021/04/11.
//

import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = artwork.markerTintColor
            glyphText = String(artwork.discipline.first!)
        }
    }
}
