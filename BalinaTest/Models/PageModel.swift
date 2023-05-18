//
//  PageModel.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 16.05.23.
//

import Foundation

struct PageModel: Decodable {
  let content: [Content]
  let page: Int
  let pageSize: Int
  let totalElements: Int
  let totalPages: Int
}

struct Content: Decodable {
  let id: Int
  let name: String
  let image: String?
}
