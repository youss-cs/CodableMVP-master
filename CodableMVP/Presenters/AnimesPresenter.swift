//
//  AnimesPresenter.swift
//  CodableMVP
//
//  Created by YouSS on 4/30/19.
//  Copyright © 2019 OuSS. All rights reserved.
//

import Foundation

protocol AnimesDelegate: class{
    func showProgress()
    func hideProgress()
    func setAnimes(animes: [Anime])
}

class AnimesPresenter{
    weak var delegate: AnimesDelegate?
    
    init(delegate: AnimesDelegate) {
        self.delegate = delegate
    }
    
    func fetchAnimes(){
        delegate?.showProgress()
        AnimeService.instance.getAnimeList { (result) in
            self.delegate?.hideProgress()
            
            switch result {
            case .success(let season):
                self.delegate?.setAnimes(animes: season.anime)
            case .failure(let error):
                print(error)
            }
        }
    }
}
