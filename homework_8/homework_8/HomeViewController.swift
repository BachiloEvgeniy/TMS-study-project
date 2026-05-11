//
//  HomeViewController.swift
//  homework_8
//
//  Created by Evgeniy Bachilo on 11.05.2026.
//


import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // background
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background3")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // title label
        let titleLabel = UILabel()
        titleLabel.text = "Welcome user!"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        
        // subTitle label
        let subTitleLabel = UILabel()
        subTitleLabel.text = "Appartment control page 🏠"
        subTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        subTitleLabel.textColor = .white
        view.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        // light label
        let lightLabel = UILabel()
        lightLabel.text = "Lights"
        lightLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lightLabel.textColor = .white
        view.addSubview(lightLabel)
        lightLabel.translatesAutoresizingMaskIntoConstraints = false
        lightLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 50).isActive = true
        lightLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        lightLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        // segment control
        let segmentControl = UISegmentedControl(items: ["On", "Off"])
        segmentControl.selectedSegmentIndex = 0
        view.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: lightLabel.bottomAnchor, constant: 10).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true

        segmentControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        // door label
        
        let doorLabel = UILabel()
        doorLabel.text = "Door"
        doorLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        doorLabel.textColor = .white
        view.addSubview(doorLabel)
        doorLabel.translatesAutoresizingMaskIntoConstraints = false
        doorLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50).isActive = true
        doorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        doorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        // segment control door
        let segmentControlDoor = UISegmentedControl(items: ["Lock", "Unlock"])
        segmentControlDoor.selectedSegmentIndex = 0
        view.addSubview(segmentControlDoor)
        segmentControlDoor.translatesAutoresizingMaskIntoConstraints = false
        segmentControlDoor.topAnchor.constraint(equalTo: doorLabel.bottomAnchor, constant: 10).isActive = true
        segmentControlDoor.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true

        segmentControlDoor.widthAnchor.constraint(equalToConstant: 200).isActive = true
        

        
        // AC label
        
        let aCLabel = UILabel()
        aCLabel.text = "A/C"
        aCLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        aCLabel.textColor = .white
        view.addSubview(aCLabel)
        aCLabel.translatesAutoresizingMaskIntoConstraints = false
        aCLabel.topAnchor.constraint(equalTo: segmentControlDoor.bottomAnchor, constant: 50).isActive = true
        aCLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        aCLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        // segment control door
        let segmentControlAc = UISegmentedControl(items: ["Auto", "On", "Off"])
        segmentControlAc.selectedSegmentIndex = 0
        view.addSubview(segmentControlAc)
        segmentControlAc.translatesAutoresizingMaskIntoConstraints = false
        segmentControlAc.topAnchor.constraint(equalTo: aCLabel.bottomAnchor, constant: 10).isActive = true
        segmentControlAc.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true

        segmentControlAc.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Temparature label
        
        let tempLabel = UILabel()
        tempLabel.text = "Temperature"
        tempLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        tempLabel.textColor = .white
        view.addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.topAnchor.constraint(equalTo: segmentControlAc.bottomAnchor, constant: 50).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        // Temperatore range
        let tempSlider = UISlider()
        tempSlider.minimumValue = 10
        tempSlider.maximumValue = 40
        tempSlider.tintColor = .systemBlue
        tempSlider.maximumTrackTintColor = .darkGray
        tempSlider.value = 20
        view.addSubview(tempSlider)
        tempSlider.translatesAutoresizingMaskIntoConstraints = false
        tempSlider.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10).isActive = true
        tempSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        tempSlider.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        // alarm button
        let alarmButton = UIButton()
        alarmButton.setTitle("Alarm", for: .normal)
        alarmButton.setTitleColor(.red, for: .normal)
        alarmButton.backgroundColor = .white
        
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 24,
            bottom: 8,
            trailing: 24
        )
        config.baseBackgroundColor = .white
        config.background.cornerRadius = 0
        alarmButton.configuration = config
        
        view.addSubview(alarmButton)
        alarmButton.translatesAutoresizingMaskIntoConstraints = false
        alarmButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        alarmButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        
        
    }

}
