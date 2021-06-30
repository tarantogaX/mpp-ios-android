import UIKit
import SharedCode

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet private var label: UILabel!
    @IBOutlet private var pickerViewDeparture: UIPickerView!
    @IBOutlet private var pickerViewArrival: UIPickerView!
    @IBOutlet private var submitButton: UIButton!
    
    private let presenter: ApplicationContractPresenter = ApplicationPresenter()
    
    let stations = ["Colchester [COL]","Ipswich [IPS]","Birmingham New Street [BHM]","Kings Cross [KGX]", "Cambridge [CBG]"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stations[row]
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let arr = pickerViewArrival.selectedRow(inComponent: 0)
        let dep = pickerViewDeparture.selectedRow(inComponent: 0)
        let departure = stations[dep].suffix(4).prefix(3)
        let arrival = stations[arr].suffix(4).prefix(3)
        if let url = URL(string: "https://www.lner.co.uk/travel-information/travelling-now/live-train-times/depart/" + departure + "/" + arrival +  "/#LiveDepResults") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewTaken(view: self)
        
        self.pickerViewDeparture.delegate = self
        self.pickerViewDeparture.dataSource = self
        
        self.pickerViewArrival.delegate = self
        self.pickerViewArrival.dataSource = self
    }
}

extension ViewController: ApplicationContractView {
    func setLabel(text: String) {
    }
}
