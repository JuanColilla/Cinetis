//
//  TableViewController.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 21/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    var viewModel: SettingsViewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        self.tableView.tableFooterView = UIView()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellRow", for: indexPath) as? SettingsViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.label.text = viewModel.constants.firstRowText
            cell.linkBasetisImage.isHidden = false
        } else if indexPath.row == 1 {
            cell.label.text = viewModel.constants.secondRowText
            cell.linkBasetisImage.isHidden = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if let url = URL(string: viewModel.constants.linkToBasetis) {
                let vc = SFSafariViewController(url: url)
                
                vc.delegate = self
                self.present(vc, animated: true)
            }
        }
        
    }

    // MARK: - Navigation
    
    @IBAction func goToProfileScreen(_ sender: UIBarButtonItem) {
        
        let nextStoryboard = UIStoryboard(name: "ProfileScreen", bundle: Bundle.main)
        
        if let viewController = nextStoryboard.instantiateViewController(withIdentifier: "profileScreen") as? ProfileScreenViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    
    }
    private func setupNavigationBarItems() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let button = UIBarButtonItem(image: UIImage(systemName: "person.circle"))
        button.target = self
        button.action = #selector(goToProfileScreen(_:))
        
        navigationItem.rightBarButtonItem = button
    }
}
