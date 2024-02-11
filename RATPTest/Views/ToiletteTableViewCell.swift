//
//  ToiletteTableViewCell.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import UIKit
import Reusable

class ToiletteTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var pmrIcon: UIImageView!
    @IBOutlet private weak var distanceMainContainer: UIView!
    @IBOutlet private weak var distanceContainer: UIView!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        timeLabel.text = nil
        pmrIcon.isHidden = true
        distanceMainContainer.isHidden = true
    }

    func configure(with model: ToiletteModel, distance: Double?) {
        setup()
        titleLabel.text = model.adresse ?? "N/A"
        subtitleLabel.text = model.gestionnaire
        timeLabel.text = model.displayHoraire.value
        pmrIcon.isHidden = !model.hasPmrAccess
        distanceMainContainer.isHidden = distance == nil

        if let distance {
            distanceLabel.text = LocationService.displayDistance(distance)
        }

        let color: UIColor = {
            guard let isOpen = model.isOpen else { return UIColor.blue }
            return isOpen ? UIColor.green : UIColor.red
        }()

        distanceContainer.backgroundColor = color.withAlphaComponent(0.7)
    }
}

private extension ToiletteTableViewCell {
    func setup() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subtitleLabel.font = .systemFont(ofSize: 10, weight: .medium)
        distanceLabel.font = .systemFont(ofSize: 12, weight: .bold)
        timeLabel.font = .systemFont(ofSize: 10, weight: .regular)

        titleLabel.textColor = UIColor.label
        subtitleLabel.textColor = UIColor.secondaryLabel
        timeLabel.textColor = UIColor.secondaryLabel

        pmrIcon.image = UIImage(resource: ImageResource.figureRoll)
        pmrIcon.tintColor = UIColor.blue

        distanceContainer.layer.masksToBounds = true
        distanceContainer.layer.cornerRadius = 16.0
    }
}
