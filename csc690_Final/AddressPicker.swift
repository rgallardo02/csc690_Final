//
//  AddressPicker.swift
//  csc690_Final
//
//  Created by Rodrigo Gallardo on 12/8/20.
//

import UIKit
import WebKit

struct LastAddress {
    let abbreviation: String
    let name: String
}

class AddressPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var addressPicker: UIPickerView!
    
    var addresses: [LastAddress] = [
        LastAddress(abbreviation: "San Francisco", name: "333 Post st San Francsico"),
        LastAddress(abbreviation: "San Francisco", name: "1 Ferry Building San Francisco"),
        LastAddress(abbreviation: "South San Francisco", name: "394 Grand Ave South San Francisco"),
        LastAddress(abbreviation: "San Francisco", name: "Golden Gate Bridge Plaza San Francisco"),
        LastAddress(abbreviation: "San Francisco", name: "Mission District San Francisco"),
        LastAddress(abbreviation: "San Francisco", name: "1525 Haight st San Francisco"),
        LastAddress(abbreviation: "San Francisco", name: "Japantown San Francisco")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressPicker.delegate = self
        addressPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addresses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addresses[row].name
    }
    
    
}
