//
//  LoadingCell.swift
//  BalinaTest
//
//  Created by Eugene Kudritsky on 16.05.23.
//

import UIKit

final class LoadingCell: UITableViewCell {

  //MARK: - Property

  let activityIndicator = UIActivityIndicatorView()

  //MARK: - Init

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: - Constraints

extension LoadingCell {
  func setConstraints() {
    contentView.addSubview(activityIndicator)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
}
