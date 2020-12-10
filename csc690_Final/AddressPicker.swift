//
//  AddressPicker.swift
//  csc690_Final
//
//  Created by Rodrigo Gallardo on 12/8/20.
//

import UIKit

struct LastAddress {
    let abbreviation: String
    let name: String
}

class AddressPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var addy : String = ""
    
    @IBOutlet weak var addressPicker: UIPickerView!
    
    var addresses: [LastAddress] = [
        LastAddress(abbreviation: "Palace Of Fine Arts", name: "3601 Lyon St San Francsico"),
        LastAddress(abbreviation: "Embarcadero Street", name: "1 Ferry Building San Francisco"),
        LastAddress(abbreviation: "San Francisco State", name: "1600 Holloway Ave San Francisco"),
        LastAddress(abbreviation: "Golden Gate Bridge", name: "Golden Gate Bridge Plaza San Francisco"),
        LastAddress(abbreviation: "Mission District", name: "Mission District San Francisco"),
        LastAddress(abbreviation: "Haight-Ashbury", name: "1525 Haight st San Francisco"),
        LastAddress(abbreviation: "Japantown", name: "Japantown San Francisco")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        addressPicker.delegate = self
        addressPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return UIScreen.main.bounds.width - 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addresses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width - 100, height: 60))
        let label = UILabel(frame: CGRect(x:0, y:0, width: view.bounds.width, height: view.bounds.height))
        
        label.text = addresses[row].abbreviation
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.clipsToBounds = true
        view.layer.cornerRadius = view.bounds.height/2
        view.layer.borderWidth = 2.5
        view.layer.borderColor = UIColor.systemBlue.cgColor
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addy = addresses[row].name
        print(addy)
    }
}
