//
//  CVTableViewCellFactory.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 10.12.2022.
//

import Foundation
import UIKit

protocol CVTableViewCellFactoryType {
    func getCellFor(_ cv: UserCV, templateType: TemplateType, delegate: CVFieldCompletion, in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

class CVTableViewCellFactory: CVTableViewCellFactoryType {
    func getCellFor(_ cv: UserCV, templateType: TemplateType, delegate: CVFieldCompletion, in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        switch templateType.fieldType {
        case .smallTextInput:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallCVCreationTableViewCell.identifier, for: indexPath) as? SmallCVCreationTableViewCell else {
                return UITableViewCell()
            }
            cell.configureWith(cv, templateType: templateType, delegate: delegate)
            return cell
        case .bigTextInput:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BigCVCreationTableViewCell.identifier, for: indexPath) as? BigCVCreationTableViewCell else {
                return UITableViewCell()
            }
            cell.configureWith(cv, templateType: templateType, delegate: delegate)
            return cell
        }
    }
}
