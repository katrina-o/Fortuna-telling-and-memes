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
        searchBar.barTintColor = .lightText
        
        return searchBar
    }()
   
    let memSearchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get prediction", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .systemPink.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(backPredictionButton), for: .touchUpInside)
        
        return button
    }()
    
    let memImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "catPre")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
//        image.setImage(image.image, animated: true)
        return image
    }()
    let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("👍🏼", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.backgroundColor = .systemPink.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(getPredictionButton), for: .touchUpInside)
        
        return button
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.setTitle("👎🏼", for: .normal) 
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.backgroundColor = .systemYellow.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(backPredictionButton), for: .touchUpInside)
        
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        MemManager.getMemes { response in
            self.memes = response
        }
        title = "Fortuna Telling and Memes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(likeAndSave))
        initialize()
    }
  
    @objc func likeAndSave( sender: UIButton) {
        
    }
    @objc func getPredictionButton( sender: UIButton) {
        memImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 1.35, delay: 0,
                                       usingSpringWithDamping: 0.25,
                                       initialSpringVelocity: 5,
                                       options: .curveEaseOut,
                                       animations: {
                                        
                self.memImage.transform = .identity
            })
    }
    
    @objc func backPredictionButton( sender: UIButton) {
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
        view.backgroundColor = .systemBackground
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
            make.width.equalTo(200)
        }
        
        memImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        yesButton.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().inset(120)
            make.leading.equalToSuperview().inset(90)
        }
        
        noButton.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().inset(120)
            make.trailing.equalToSuperview().inset(90)
        }
    }
}

//extension UIImageView{
//    func setImage(_ image: UIImage?, animated: Bool = true) {
//        let duration = animated ? 0.3 : 0.0
//        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
//            self.image = image
//        }, completion: nil)
//    }
//}
