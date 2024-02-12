//
//  ViewController.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import UIKit
import CoreLocation
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var filterButton: UIBarButtonItem!

    private lazy var refreshControl = UIRefreshControl()

    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        load()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let mapViewController = segue.destination as? MapViewController {
            let mapViewModel = viewModel.prepareMapViewModel()
            mapViewController.viewModel = mapViewModel
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            viewModel.fetch(from: viewModel.cursor + indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.filteredItems[indexPath.row]
        let viewModel = DetailsViewModel(toiletteModel: item)
        let rootView = DetailsView(viewModel: viewModel)

        let viewController = UIHostingController(rootView: rootView)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - View Setup
private extension ViewController {
    func setup() {
        viewModel.delegate = self
        setupTableView()
        setupRefreshControl()
        setupFilterMenu()
    }

    func setupFilterMenu() {
        let pmrFilterItem = UIAction(title: "Accès PMR", image: viewModel.filter == .pmr ? UIImage(resource: ImageResource.checkmarkDone) : nil) { [weak self] _ in
            self?.viewModel.filter = .pmr
            self?.setupFilterMenu()
        }

        let openFilterItem = UIAction(title: "Ouvert", image: viewModel.filter == .open ? UIImage(resource: ImageResource.checkmarkDone) : nil) { [weak self] _ in
            self?.viewModel.filter = .open
            self?.setupFilterMenu()
        }

        let resetItem = UIAction(title: "Par défaut") { [weak self] _ in
            self?.viewModel.filter = nil
            self?.setupFilterMenu()
        }

        let menu = UIMenu(title: "Filtre", options: .displayInline, children: [pmrFilterItem, openFilterItem, resetItem])

        filterButton.menu = menu
    }

    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "👀")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    func setupTableView() {
        tableView.register(cellType: ToiletteTableViewCell.self)
        tableView.dataSource = viewModel.makeDataSource(withTableView: tableView)
        tableView.delegate = self
    }
}


// MARK: - Data Handling
extension ViewController: MainViewModelProtocol {
    func didEndRefreshing() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func shouldShowEmptyView(show: Bool) {
        if show {
            self.tableView.setEmptyMessage(viewModel.emptyViewMessage)
        } else {
            self.tableView.restore()
        }
    }

    @objc func refresh() {
        refreshControl.beginRefreshing()
        viewModel.refresh()
    }

    func load() {
        refreshControl.beginRefreshing()
        viewModel.fetch()
    }
}
