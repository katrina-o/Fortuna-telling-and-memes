//
//  ViewController.swift
//  Fortuna telling and memes
//
//  Created by Катя on 25.09.2024.
//

import UIKit
import SnapKit
import SDWebImage

class ViewController: UIViewController, UISearchBarDelegate {

    var memNumber = 0
    var memes: MemModel = MemModel(data: DataModel(memes: []))
    
    let memSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "inter you question"
        searchBar.barTintColor = .systemCyan
        
        return searchBar
    }()
   
    let memSearchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get prediction", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(backPredictionButton), for: .touchUpInside)
        
        return button
    }()
    
    let memImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "catPre")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("👍🏼", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.tag = 2
        button.addTarget(self, action: #selector(getPredictionButton), for: .touchUpInside)
        
        return button
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.setTitle("👎🏼", for: .normal) 
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.addTarget(self, action: #selector(backPredictionButton), for: .touchUpInside)
        
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        MemManager.getMemes { response in
            self.memes = response
        }
        initialize()
    }
  
    
    @objc func getPredictionButton( sender: UIButton) -> Bool {
        if yesButton.currentTitle == sender.currentTitle {
            return true
        } else {
            return false
        }
        getMemImages()
    }
    
    @objc func backPredictionButton( sender: UIButton) {
        let userAnswer = sender.currentTitle!
        getMemImages()
        nextMem()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func getMemImages() {
        memImage.sd_setImage(with: URL(string: memes.data.memes[memNumber].url))
    }
    
    func nextMem() {
        if memNumber + 1 < memes.data.memes.count {
            memNumber += 1
        } else {
            memNumber = 0
        }
    }
    func backMem(memNumber: Int) {
        print(memNumber)
    }
    
    func initialize() {
        view.backgroundColor = .systemCyan
        view.addSubview(memSearchBar)
        view.addSubview(memSearchButton)
        view.addSubview(memImage)
        view.addSubview(yesButton)
        view.addSubview(noButton)
        
        memSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        memSearchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(180)
        }
        
        memImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(200)
        }
        
        yesButton.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().inset(120)
            make.leading.equalToSuperview().inset(100)
        }
        
        noButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().inset(120)
            make.trailing.equalToSuperview().inset(100)
        }
    }
}
