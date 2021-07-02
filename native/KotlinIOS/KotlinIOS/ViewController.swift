import UIKit
import SharedCode

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, ApplicationContractView
{
    func setLabel(text: String) {
    }
    
    @IBOutlet private var label: UILabel!
    @IBOutlet private var pickerViewDeparture: UIPickerView!
    @IBOutlet private var pickerViewArrival: UIPickerView!
    @IBOutlet private var submitButton: UIButton!
    @IBOutlet private var trainsTable: UITableView!
    @IBOutlet private var trainTableViewCell: UITableViewCell!
    
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
    
    private let presenter: ApplicationContractPresenter = ApplicationPresenter()
    
    var stations: [String] = []
    //"Colchester","Ipswich","Birmingham New Street","Kings Cross", "Cambridge"
    
    var codes: [String] = []
    //"COL","IPS","BHM","KGX", "CBG"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stations[row]
    }
    
    
    var tableRows: [String] = []
    
    func tableView(_ tableView: UITableView) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = tableRows[indexPath.row]
        return cell
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let departure = codes[pickerViewDeparture.selectedRow(inComponent: 0)]
        let arrival = codes[pickerViewArrival.selectedRow(inComponent: 0)]
        
        presenter.getTrainTimes(departureStation: String(departure), arrivalStation: String(arrival))
        
//        onGetStationsList(stations: ["cdc", "dewfd", "dewf"], codes: ["wer", "sdf", "fe7"])
    }
    
    func updateSearchResults(results: [String]) {
        tableRows = results
        self.trainsTable.reloadData()
    }
    
    func onGetStationsList(stations newStations: [String], codes newCodes: [String]) {
            stations = newStations
            codes = newCodes
        self.pickerViewDeparture.reloadComponent(0)
        self.pickerViewArrival.reloadComponent(0)
    }
}
