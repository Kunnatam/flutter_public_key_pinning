//
//  SSLPinner.swift
//  public_key_pinning
//
//  Created by Kunnatam Na Takuatung on 6/3/2565 BE.
//

import Foundation
import Alamofire

struct Evaluation: Codable {
    let hostName, fileName: String
}

class SSLPinner {
  let session: Session
  
  public init(_ evaluations:[Evaluation]) {
    var evaluators = [String:PublicKeysTrustEvaluator]()
//    let evaluators = [
//      "dev.clicknic.co": PublicKeysTrustEvaluator(keys: [Certificates.devKey]),
//      "uat.clicknic.co": PublicKeysTrustEvaluator(keys: [Certificates.uatKey]),
//      "app.clicknic.co": PublicKeysTrustEvaluator(keys: [Certificates.prodKey]),
//    ]
//    for element in evaluations {
//      if let ev = Evaluation(from: element) {
//
//      }
//    }
    session = Session(serverTrustManager: ServerTrustManager(evaluators: evaluators))
  }
  
  public func request(url:String, headers:Dictionary<String, String>?, closure: @escaping (Bool) -> Void) {
    session.request(url, method: .get, parameters: headers).responseData() {
      response in
      debugPrint(response)
      switch response.result {
      case .success:
        closure(true)
        break
      case .failure:
        closure(false)
        break
      }
    }
  }
}
