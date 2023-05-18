//
//  Builder.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 18.05.23.
//

import UIKit

final class Builder: BuilderProtocol {

  static func createPhotoVCModule() -> UIViewController {
    let networkService = NetworkService()
    let viewModel = PhotoViewModel(networkService: networkService)
    let view = PhotoViewController(viewModel: viewModel)
    return view
  }
}
