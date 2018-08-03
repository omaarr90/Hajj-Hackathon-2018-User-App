//
//  ApiManager.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import Foundation

import HermesNetwork
import Alamofire
import Hydra

class ApiManager {
    
    public static let shared = ApiManager()
    
    var cnfg: ServiceConfig
    var service: Service
    
    private init() {
        self.cnfg = ServiceConfig(base: "https://api.fouad.io")!
        self.service = Service(self.cnfg)
    }
}


//Api Request
extension ApiManager {
//    func login(_ username: String, withPassword password: String, completion: @escaping (User?, Error?) -> Void) {
//        let op: JSONOperation<User> = JSONOperation<User>()
//        
////        let bodyData = "username=\(username)&password=\(password)".data(using:String.Encoding.ascii, allowLossyConversion: false)
//        op.request = Request(method: .post, endpoint: "/user/login", params: nil, fields: nil, body: RequestBody.json(["username": username, "password": password]))
//        
//        op.request?.headers = ["Content-Type": "application/json"]
//        op.onParseResponse = { json in
//            return User(json["result"])!
//        }
//        op.execute(in: self.service).then { user in
//            completion(user, nil)
//            }.catch { error in
//                completion(nil, error)
//        }
//    }
    
    func getAllMachines(completion: @escaping ([VendingMachine]?, Error?) -> Void) {
        let op: JSONOperation<[VendingMachine]> = JSONOperation<[VendingMachine]>()
        
        op.request = Request(method: .get, endpoint: "/vm/all", params: nil, fields: nil, body: nil)
        
//        op.request?.headers = ["Content-Type": "application/json"]
        op.onParseResponse = { json in
            return VendingMachine.load(list: json["result"].arrayValue)
        }
        op.execute(in: self.service).then { vendingMachine in
            completion(vendingMachine, nil)
            }.catch { error in
                completion(nil, error)
        }
    }

}
