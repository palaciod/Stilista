//
//  RatingView.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/24/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RatingView: UIView {
    var stylistValue: Int?
    let firstStar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let secondStar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let thirdStar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let fourthStar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let fifthStar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "★"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30.0)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero )
        setUpStar(star: firstStar, x: self.leadingAnchor)
        setUpStar(star: secondStar, x: firstStar.trailingAnchor)
        setUpStar(star: thirdStar, x: secondStar.trailingAnchor)
        setUpStar(star: fourthStar, x: thirdStar.trailingAnchor)
        setUpStar(star: fifthStar, x: fourthStar.trailingAnchor)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.setValue()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStar(star: UILabel, x: NSLayoutXAxisAnchor){
        self.addSubview(star)
        star.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        star.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        star.leadingAnchor.constraint(equalTo: x).isActive = true
        star.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5).isActive = true
    }
    
    func setValue(){
        switch stylistValue{
        case 0:
            firstStar.text = "☆"
            secondStar.text = "☆"
            thirdStar.text = "☆"
            fourthStar.text = "☆"
            fifthStar.text = "☆"
            break
        case 1:
            firstStar.text = "★"
            secondStar.text = "☆"
            thirdStar.text = "☆"
            fourthStar.text = "☆"
            fifthStar.text = "☆"
            break
        case 2:
            firstStar.text = "★"
            secondStar.text = "★"
            thirdStar.text = "☆"
            fourthStar.text = "☆"
            fifthStar.text = "☆"
            break
        case 3:
            firstStar.text = "★"
            secondStar.text = "★"
            thirdStar.text = "★"
            fourthStar.text = "☆"
            fifthStar.text = "☆"
            break
        case 4:
            firstStar.text = "★"
            secondStar.text = "★"
            thirdStar.text = "★"
            fourthStar.text = "★"
            fifthStar.text = "☆"
            break
        case 5:
            firstStar.text = "★"
            secondStar.text = "★"
            thirdStar.text = "★"
            fourthStar.text = "★"
            fifthStar.text = "★"
            break
        default:
        break
        }
    }

}
