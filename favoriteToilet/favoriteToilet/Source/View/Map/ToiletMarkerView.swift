//
//  ToiletMarkerView.swift
//  favoriteToilet
//
//  Created by dale on 2022/08/30.
//

import MapKit.MKAnnotationView
import UIKit

final class ToiletMarkerView: MKAnnotationView {
    static var identifier: String {
        return "\(self)"
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage(systemName: "mappin")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        image = UIImage(systemName: "mappin")
    }
}
