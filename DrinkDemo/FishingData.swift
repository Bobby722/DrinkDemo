//
//  FishingData.swift
//  DrinkDemo
//
//  Created by 林嫈沛 on 2019/4/16.
//  Copyright © 2019 lohaslab. All rights reserved.
//

import Foundation
class Cdrink{
    static let Drink = Cdrink()
    func upload(data: [String: Any] , finished:@escaping ((Bool)->())) {
        let apiStr = "https://sheetdb.io/api/v1/w25bt0zcfqocr"
        if let urlStr = apiStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(urlStr)
            var urlRequest = URLRequest(url:url)
            
            // Set request HTTP method to GET. It could be POST as well
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do{
                let data = try JSONSerialization.data(withJSONObject: data, options: [])
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler:{(retData, res,err) in
                    if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:String] {
                        print(dic)
                        finished(false)
                    }else{
                        finished(true)
                    }
                })
                task.resume()
            }catch{
                print(error)
            }
        }
    }
    func download(finish:@escaping (([CdrinkOrder]?)->())) {
        var item = [CdrinkOrder]()
        let apiStr = "https://sheetdb.io/api/v1/w25bt0zcfqocr"
        if let urlStr = apiStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(urlStr)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in//另一個執行緒
                if let data = data
                {
                    do {
                        var i = 0
                        let Results = try JSONDecoder().decode(Array<DrinkArr>.self, from: data)
                        for _ in Results{
                            let name = Results[i].name
                            let drink = Results[i].drink
                            let sweet = Results[i].sweet
                            let ice = Results[i].ice
                            let size = Results[i].size
                            let time = Results[i].time
                            item.append(CdrinkOrder(name: name, drink: drink, sweet: sweet, ice: ice, size: size, time: time))
                            i=i+1
                        }
                        print(Results)
                        if item.count != 0{
                            finish(item)
                        }else{
                            finish(nil)
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
