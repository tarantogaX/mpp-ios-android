import UIKit
import SharedCode

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource
                       {

    @IBOutlet private var label: UILabel!
    @IBOutlet private var pickerViewDeparture: UIPickerView!
    @IBOutlet private var pickerViewArrival: UIPickerView!
    @IBOutlet private var submitButton: UIButton!
    @IBOutlet private var trainsTable: UITableView!
    @IBOutlet private var trainTableViewCell: UITableViewCell!
    
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
    
    
    var tableRows = [["cds", "vcdsfv", "dsv", "vdv"], ["cds", "vcdsfv", "dsv", "vdv"]]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = tableRows[indexPath.section][indexPath.row]
        return cell
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let arr = pickerViewArrival.selectedRow(inComponent: 0)
        let dep = pickerViewDeparture.selectedRow(inComponent: 0)
        let departure = stations[dep].suffix(4).prefix(3)
        let arrival = stations[arr].suffix(4).prefix(3)
        
        let presenter = ApplicationPresenter()
        presenter.getTrainTimes(departureStation: String(departure), arrivalStation: String(arrival))
        
//        if let url = URL(string: "https://www.lner.co.uk/travel-information/travelling-now/live-train-times/depart/" + departure + "/" + arrival +  "/#LiveDepResults") {
//            UIApplication.shared.open(url)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewTaken(view: self)
        
        self.pickerViewDeparture.delegate = self
        self.pickerViewDeparture.dataSource = self
        
        self.pickerViewArrival.delegate = self
        self.pickerViewArrival.dataSource = self
        
        self.trainsTable.delegate = self
        self.trainsTable.dataSource = self
    }
}

extension ViewController: ApplicationContractView {
    func setLabel(text: String) {
    }
}
