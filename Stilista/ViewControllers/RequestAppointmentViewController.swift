//
//  RequestAppointmentViewController.swift
//  Stilista
//
//  Created by Daniel Palacio on 1/26/20.
//  Copyright © 2020 Daniel Palacio. All rights reserved.
//

import UIKit

class RequestAppointmentViewController: UIViewController {
    var index: Int?
    let navBar: NavBar = {
        let navBar = NavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.leftButton.setTitle(" ◀︎ Back", for: .normal)
        navBar.rightButton.setTitle("", for: .normal)
        return navBar
    }()
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 20.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textView
    }()
    
    private let dayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        picker.layer.cornerRadius = 12
        picker.layer.masksToBounds = true
        picker.datePickerMode = UIDatePicker.Mode.dateAndTime
        var dateComponents = DateComponents()
        picker.minimumDate = Calendar.current.date(from: dateComponents)
        return picker
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.6246554719, blue: 0.8705882353, alpha: 1)
        button.setTitle("Confim Appointment", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let stilistaApi = StilistaApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(navBar)
        view.addSubview(messageTextView)
        view.addSubview(dayPicker)
        view.addSubview(sendButton)
        setUpNavBar()
        setUpMessageTextView()
        setUpDayPickerPicker()
        setUpButton()
    }
    deinit {
        print("Releasing RequestAppointmentViewController from memroy.")
    }
    /**
     An overrided method that removes the systems keyboard when any non textfield is touched.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUpNavBar(){
        navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        // Adding targets to the left and right buttons
        navBar.leftButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
    }
    
    private func setUpMessageTextView(){
        messageTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageTextView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        messageTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setUpDayPickerPicker(){
        dayPicker.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 30).isActive = true
        dayPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.1).isActive = true
        dayPicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8).isActive = true
    }
    
    private func setUpButton(){
        sendButton.topAnchor.constraint(equalTo: dayPicker.bottomAnchor, constant: 30).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: dayPicker.leadingAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: dayPicker.trailingAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        sendButton.addTarget(self, action: #selector(post), for: .touchUpInside)
    }
    
    
    
    @objc private func popBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc private func post(){
        if messageTextView.text.isEmpty{
            print("Fill in the message")
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let month = dateFormatter.string(from: dayPicker.date)
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: dayPicker.date)
            dateFormatter.dateFormat = "h:mm a"
            let time = dateFormatter.string(from: dayPicker.date)
            print("This is my date: \(month) \(day) at \(time)")
            
            let main = navigationController?.viewControllers[0] as! MainViewController
            guard let stylistID = main.stylists?[index!]._id else {return}
            guard let name = main.clientDetails?.name else {return}
            guard let userID = main.clientDetails?._id else {return}
            let date = "\(month) \(day) at \(time)"
            stilistaApi.createJob(name: name, userID: userID, message: messageTextView.text, stylist: stylistID, appointment: date)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    


}
