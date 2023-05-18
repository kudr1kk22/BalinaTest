//
//  PhotoViewModelProtocol.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 16.05.23.
//

import UIKit

protocol PhotoViewModelProtocol {
  var model: [Content] { get set }
  var isLoading: Bool { get set }
  var currentPage: Int { get set }
  var errorHandler: ((String) -> Void)? { get set }
  var loadingCellIndexPath: IndexPath? { get set }
  func fetchPhotoData(completion: @escaping ((Bool, Bool) -> Void))
  func sendData(contentModel: ImagePostRequest, completion: @escaping (String, Bool) -> Void)
  func refreshPhotoData(completion: @escaping () -> Void)
}
