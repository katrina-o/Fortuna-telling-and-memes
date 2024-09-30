//
//  MemManager.swift
//  Fortuna telling and memes
//
//  Created by Катя on 27.09.2024.
//


import Foundation


let memesApi = "https://api.imgflip.com/get_memes"

struct MemManager {
    
    static func getMemes(completionHandler:@escaping (_ response: MemModel)->Void) {
        let url = URL(string: memesApi)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
   
        var result: MemModel?
            do{
                result = try JSONDecoder().decode(MemModel.self, from: data)
            }
            catch{
                print("Failed to convert JSON\(error)")
            }
            print(result)
        
            guard let json = result else {
                return
            }
            
            print(json)
            completionHandler(result!)
        }
        task.resume()
    }
}

