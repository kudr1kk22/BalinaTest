//
//  PhotoViewModel.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 16.05.23.
//

import Foundation
import UIKit

final class PhotoViewModel: PhotoViewModelProtocol {
  
  //MARK: - Properties
  
  var networkService: NetworkServiceProtocol
  var model: [Content] = []
  var isLoading: Bool = false
  var currentPage: Int = 0
  var errorHandler: ((String) -> Void)?
  var loadingCellIndexPath: IndexPath?
  
  //MARK: - Init
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
  
  //MARK: - Fetch photo data
  
  func fetchPhotoData(completion: @escaping ((Bool, Bool) -> Void)) {
    networkService.getPhotoTypes(currentPage: "\(currentPage)") { result in
      switch result {
      case .success(let model):
        let isEmpty = model.content.isEmpty
        if !isEmpty {
          self.model.append(contentsOf: model.content)
        }
        dump(isEmpty)
        completion(true, isEmpty)
      case .failure(let error):
        print(error.localizedDescription)
        self.handleAPIError(error)
        completion(false, false)
      }
    }
  }
  
  func refreshPhotoData(completion: @escaping () -> Void) {
    self.currentPage = 0
    networkService.getPhotoTypes(currentPage: "\(currentPage)") { result in
      switch result {
      case .success(let model):
        self.model = model.content
        completion()
      case .failure(let error):
        print(error.localizedDescription)
        self.handleAPIError(error)
        completion()
      }
    }
  }
  
  //MARK: - Send data
  
  func sendData(contentModel: ImagePostRequest, completion: @escaping (String, Bool) -> Void) {
    networkService.postRequest(contentModel: contentModel) { id, success  in
      if success {
        completion(id, true)
      } else {
        completion(APIError.connectionError.localizedDescription, false)
      }
    }
  }
  
  //MARK: - Errors
  
  func handleAPIError(_ error: Error) {
    if let apiError = error as? APIError {
      switch apiError {
      case .unknownError:
        errorHandler?("Неизвестная ошибка")
      case .connectionError:
        errorHandler?("Ошибка соединения")
      }
    } else {
      errorHandler?(error.localizedDescription)
    }
  }
  
}
