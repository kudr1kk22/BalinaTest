//
//  NetworkServiceProtocol.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 16.05.23.
//

import Foundation

protocol NetworkServiceProtocol {
  func getPhotoTypes(currentPage: String, completion: @escaping (Result<PageModel, Error>) -> Void)
  func postRequest(contentModel: ImagePostRequest, completion: @escaping (String, Bool) -> Void)
}
