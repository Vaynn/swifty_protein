//
//  ProteinListViewController.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 30/05/2021.
//

import UIKit
import Alamofire

class ProteinListViewController: UIViewController {

    @IBOutlet weak var proteinListView: UITableView!
    private var ligandsTab:[Substring]!
    private var filteredLigandsList:[Substring]!
    private var atomList = [Atom]()
    private var conectList = [Conect]()
    private var proteinName = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.proteinListView.register(UITableViewCell.self, forCellReuseIdentifier: "proteinCell")
        if let path = Bundle.main.path(forResource: "ligands", ofType: "txt") {
          do {
            let ligandsList = try String(contentsOfFile: path, encoding: .utf8)
            ligandsTab = ligandsList.split(separator: "\n")
            filteredLigandsList = ligandsList.split(separator: "\n")
            
          } catch let error {
            print(error.localizedDescription)
          }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
}

extension ProteinListViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredLigandsList.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = proteinListView.dequeueReusableCell(withIdentifier: "ProteinCell", for: indexPath) as? ProteinTableViewCell
        else {
            return UITableViewCell()
            
        }
        cell.configure(name:String(self.filteredLigandsList[indexPath.row]))
        return cell
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ProteinTableViewCell
        cell?.activityIndicator.startAnimating()
        self.proteinName = String(self.filteredLigandsList[indexPath.row])
        let protUrl = URL(string:"https://files.rcsb.org/ligands/view/\(proteinName)_ideal.pdb")
        let headers: HTTPHeaders = [
            "Content-Type": "text/plain"
        ]

        _ = AF.request(protUrl!, headers: headers).responseString{response in
            switch response.result{
                case .success(let data):
                    let pdbTab = data.split(separator: "\n")
                    var conectList = [Conect]()
                    self.atomList.removeAll()
                    for t in pdbTab{
                        if (t.contains("ATOM")){
                            self.atomList.append(Atom(with: String(t)))
                        } else if (t.contains("CONECT")){
                            conectList.append(Conect(with: String(t)))
                        }
                    }
                    self.conectList = conectList.filter{$0.connectTab.count > 0}
                    if ((self.conectList.count <= self.atomList.count) || (self.conectList.count == 0 && self.atomList.count == 1)){
                        cell?.activityIndicator.stopAnimating()
                        self.performSegue(withIdentifier: "segueToProteinView", sender: nil)
                    } else {
                        
                        self.impossibleToLoadAlert()
                    }
            case .failure(_):
                
                self.impossibleToLoadAlert()
            }
        }
    }
    
    func impossibleToLoadAlert(){
        let alert = UIAlertController(title: "Error", message: "Impossible to load the ligand.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToProteinView"{
            let vc = segue.destination as? ProteinViewController
            vc?.atomList = atomList
            vc?.conectList = conectList
            vc?.proteinName = proteinName
            vc?.AtomInfoTab = getAtomInfoTab()
        }
    }
}


extension ProteinListViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("tutututu")
        let text: String = self.searchBar.text ?? ""
        print(text)
        self.filteredLigandsList = searchText.isEmpty ? self.ligandsTab : self.ligandsTab.filter {(item: Substring) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.filteredLigandsList.sorted{$0 > $1}
        self.proteinListView.reloadData()
    }
    
}


