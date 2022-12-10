//
//  SmallCVCreationTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class SmallCVCreationTableViewCell: CVCreationTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailsTextField: UITextField!
    
    // MARK: - Parameters
    
    static let identifier: String = "SmallCVCreationTableViewCell"
    
    // MARK: - IBActions
    
    @IBAction func editingDidChange(_ sender: Any) {
        guard let templateType = templateType else {
            return
        }
        
        delegate?.fieldUpdated(withText: detailsTextField.text ?? "", for: templateType)
    }
    
    // MARK: - Instance functions
    
    override func configureWith(_ cv: UserCV, templateType: TemplateType, delegate: CVFieldCompletion) {
        super.configureWith(cv, templateType: templateType, delegate: delegate)
        typeLabel.text = templateType.name
        detailsTextField.text = cv.getValueForType(templateType)
        
        if templateType == .phone {
            detailsTextField.keyboardType = .phonePad
        }
    }
}
