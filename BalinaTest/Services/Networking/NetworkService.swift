//
//  NetworkService.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 16.05.23.
//

import Foundation
import UIKit

enum APIError: Error {
  case unknownError
  case connectionError
}

private enum APIUrls {
  static let baseApiURL = "https://junior.balinasoft.com/api/v2/"
}

final class NetworkService: NetworkServiceProtocol {

  typealias Parameters = [String: Any]

  //MARK: - Get photo types

  func getPhotoTypes(currentPage: String, completion: @escaping (Result<PageModel, Error>) -> Void) {

    self.createRequest(with: URL(string: APIUrls.baseApiURL + "photo/type?page=\(currentPage)"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let httpResponse = response as? HTTPURLResponse {
          switch httpResponse.statusCode {
          case 200:
            if let data = data {
              do {
                let result = try JSONDecoder().decode(PageModel.self, from: data)
                completion(.success(result))
              } catch {
                completion(.failure(APIError.connectionError))
              }
            }
          default:
            completion(.failure(APIError.unknownError))
          }
        }
      }
      task.resume()
    }
  }

  //MARK: - Post request

  func postRequest(contentModel: ImagePostRequest, completion: @escaping (String, Bool) -> Void) {

    let boundary = UUID().uuidString
    let contentType = "multipart/form-data; boundary=\(boundary)"

    self.createRequest(with: URL(string: APIUrls.baseApiURL + "photo"), type: .POST) { baseRequest in
      var request = baseRequest
      let body = NSMutableData()

      request.setValue(contentType, forHTTPHeaderField: "Content-Type")

      // Добавляем параметр name
      body.append("--\(boundary)\r\n".data(using: .utf8)!)
      body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
      body.append("\(contentModel.name)\r\n".data(using: .utf8)!)

      // Добавляем параметр photo
      body.append("--\(boundary)\r\n".data(using: .utf8)!)
      body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
      body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
      body.append(contentModel.photo)
      body.append("\r\n".data(using: .utf8)!)

      // Добавляем параметр typeId
      body.append("--\(boundary)\r\n".data(using: .utf8)!)
      body.append("Content-Disposition: form-data; name=\"typeId\"\r\n\r\n".data(using: .utf8)!)
      body.append("\(contentModel.typeId)\r\n".data(using: .utf8)!)

      body.append("--\(boundary)--\r\n".data(using: .utf8)!)
      request.httpBody = body as Data

      let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil else {
          completion(APIError.unknownError.localizedDescription, false)
          return
        }
        do {
          if let responseString = String(data: data, encoding: .utf8) {
            completion(responseString, true)
          }
          else {
            throw APIError.connectionError
          }
        }
        catch {
          print(error.localizedDescription)
          completion(APIError.unknownError.localizedDescription, false)
        }
      }
      task.resume()
    }
  }
}

//MARK: - Create Request

extension NetworkService {
  private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
    guard let apiURL = url else { return }
    var request = URLRequest(url: apiURL)
    request.httpMethod = type.rawValue
    request.timeoutInterval = 30
    completion(request)
  }
}
