//
//  AnimeListController.swift
//  CodableTuto
//
//  Created by YouSS on 2/23/19.
//  Copyright © 2019 OuSS. All rights reserved.
//

import UIKit
import JGProgressHUD

class AnimesController: UITableViewController {
    
    let cellId = "cellId"
    private let hud = JGProgressHUD(style: .dark)
    var presenter: AnimesPresenter?
    var animes = [Anime]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupPresenter()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Anime Season List"
    }
    
    fileprivate func setupTableView() {
        tableView.register(AnimeListCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }

    fileprivate func setupPresenter() {
        presenter = AnimesPresenter(delegate: self)
        presenter?.fetchAnimes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnimeListCell
        cell.anime = animes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeController = DetailsAnimeController()
        animeController.anime = animes[indexPath.row]
        navigationController?.pushViewController(animeController, animated: true)
    }
}

extension AnimesController: AnimesDelegate {
    func showProgress() {
        hud.textLabel.text = "Loading"
        guard let view = self.navigationController?.view else { return }
        hud.show(in: view)
    }
    
    func hideProgress() {
        hud.dismiss()
    }
    
    func setAnimes(animes: [Anime]) {
        self.animes = animes
        tableView.reloadData()
    }
}

