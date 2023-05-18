//
//  ImagePostRequest.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 17.05.23.
//

import Foundation

struct ImagePostRequest: Codable {
  let name: String
  let photo: Data
  let typeId: Int
}
