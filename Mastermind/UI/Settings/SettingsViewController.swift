//
//  SettingsViewController.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/22/22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var settingsService: SettingsService
    private let settings = ComplexityLevel.allCases
    
    init(settingsService: SettingsService) {
        self.settingsService = settingsService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        let tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath)
        cell.selectionStyle = .none
        let setting = settings[indexPath.row]
        if setting == settingsService.currentComplexityLevel {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        var configuration = cell.defaultContentConfiguration()
        configuration.text = setting.title
        configuration.secondaryText = setting.description
        cell.contentConfiguration = configuration
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsService.currentComplexityLevel = settings[indexPath.row]
        tableView.reloadData()
    }
}
