//
//  SSLPinner.swift
//  public_key_pinning
//
//  Created by Kunnatam Na Takuatung on 6/3/2565 BE.
//

import Foundation
import Alamofire

enum SSLPinnerError: Error {
  case fileNotFound
  case secKeyConvertFail
  case certificateFileNotFound
}

struct Evaluation: Codable {
    let hostName, fileName: String
}

class SSLPinner {
  let session: Session
  
  public init(_ evaluations:[Evaluation]) throws {
    var evaluators = [String:PublicKeysTrustEvaluator]()
    for evaluation in evaluations {
      guard let secKey:SecKey = try SSLPinner.key(filename: evaluation.fileName) else {
        throw SSLPinnerError.secKeyConvertFail
      }
      evaluators[evaluation.hostName] = PublicKeysTrustEvaluator(keys: [secKey])
    }
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
  
  private static func certificate(filename: String) throws -> SecCertificate? {
    guard let filePath = Bundle.main.path(forResource: filename, ofType: "der") else {
      throw SSLPinnerError.certificateFileNotFound
    }
    let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
    let certificate = SecCertificateCreateWithData(nil, data as CFData)!
    return certificate
  }
  
  private static func key(filename: String) throws -> SecKey? {
    guard let certificate = try certificate(filename: filename) else {
      throw SSLPinnerError.certificateFileNotFound
    }
    let publicKey = SecCertificateCopyKey(certificate)
    return publicKey!
  }
}
