//
//  ScriptsTableViewController.swift
//  Extension
//
//  Created by Carmen Morado on 4/5/21.
//

import UIKit

class ScriptsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "scriptCell")
    }
    
    weak var delegate: ScriptDelegate?
    var scripts: [Script]?
    
    //MARK: - Helper Method
    
    @objc func cancel(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let scripts = scripts else { return 1 }
        return scripts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scriptCell", for: indexPath)
        guard let scripts = scripts else { return UITableViewCell()}
        let script = scripts[indexPath.row]
        cell.textLabel?.text = script.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let scripts = scripts else { return }
        let selectedScript = scripts[indexPath.row]
        delegate?.loadSelectedScript(scriptString: selectedScript.script)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let scripts = scripts else { return }
            let scriptToDelete = scripts[indexPath.row]
            delegate?.deleteSelectedScript(scriptString: scriptToDelete.name)
            navigationController?.popViewController(animated: true)
        }
    }

}
