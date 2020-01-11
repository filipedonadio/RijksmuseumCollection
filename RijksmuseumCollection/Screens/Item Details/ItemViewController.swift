//
//  ItemViewController.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController, AlertDisplayer {

    let loadingViewController = LoadingViewController()
    let tableViewSectionHeaderHeight: CGFloat = 48

    var item: ItemDisplayable? {
        didSet {
            if let item = item {
                if let headerImage = UIImage(data: item.headerImage) {
                    let headerView = ItemHeader(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 300.0), headerImage: headerImage)
                    tableView.tableHeaderView = headerView
                }
            }
            
            tableView.reloadData()
        }
    }

    var objectNumber: String? {
        didSet {
            guard let objectNumber = objectNumber else { return }
            viewModel?.fetchItem(objectNumber: objectNumber)
        }
    }

    var viewModel: ItemViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        setupTableView()
    }

    func setupTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.identifier)
        tableView.allowsSelection = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = SectionHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 48))
        sectionHeader.label.text = item?.sections[section].name
        return sectionHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewSectionHeaderHeight
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let item = item {
            return item.sections.count
        }

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = item {
            return item.sections[section].info.count
        }

        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell

        cell.itemLabel.text = item?.sections[indexPath.section].info[indexPath.item].title
        cell.itemData.text = item?.sections[indexPath.section].info[indexPath.item].data

        return cell
    }

    func addLoadingView() {
        add(loadingViewController)
    }

    func removeLoadingView() {
        loadingViewController.remove()
    }
}

extension ItemViewController: ItemViewModelDelegate {
    
    func onLoading() {
        addLoadingView()
    }

    func onFetchCompleted(with artObject: ItemDisplayable) {
        removeLoadingView()
        item = artObject
    }

    func onFetchFailed(with reason: String) {
        removeLoadingView()

        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title, message: reason, actions: [action])
    }
}