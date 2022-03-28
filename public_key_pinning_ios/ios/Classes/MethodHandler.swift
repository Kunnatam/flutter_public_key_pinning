//
//  MethodHandler.swift
//  public_key_pinning
//
//  Created by Kunnatam Na Takuatung on 6/3/2565 BE.
//

import Foundation

class MethodHandler {
  var pinner:SSLPinner?
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "init":
        initSession(call, result: result)
    case "request":
      requestTrust(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  private func initSession(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String:Any] else {
      return result(FlutterError(code: "MISSING_ARGUMENT", message: "Unable to obtain method's arguments.", details: nil))
    }
    
    guard let evaluations = args["evaluations"] as? [[String:String]] else {
      return result(FlutterError(code: "INVALID_PARAMETER", message: "Unable to obtain method's parameter of key 'evaluations'.", details: nil))
    }
    
    do {
        let json = try JSONSerialization.data(withJSONObject: evaluations)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedEvaluations = try decoder.decode([Evaluation].self, from: json)
        decodedEvaluations.forEach{print($0)}
        pinner = try SSLPinner.init(decodedEvaluations)
        result(nil)
    } catch {
      return result(FlutterError(code: "LIBRARY_ERROR", message: "Decode Evaluations list failed", details: nil))
    }
  }
  
  private func requestTrust(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String:Any] else {
      return result(FlutterError(code: "MISSING_ARGUMENT", message: "Unable to obtain method's arguments.", details: nil))
    }
    
    guard let url = args["url"] as? String else {
      return result(FlutterError(code: "INVALID_PARAMETER", message: "Unable to obtain method's parameter(s) of key 'url'.", details: nil))
    }
    
    let headers = args["headers"] as? [String:String]
    
    if let p = pinner {
      p.request(url: url, headers: headers) {
        (success) in
        result(success)
      }
    } else {
      return result(FlutterError(code: "LIBRARY_ERROR", message: "Pinner is not being initialized.", details: nil))
    }
  }
}
