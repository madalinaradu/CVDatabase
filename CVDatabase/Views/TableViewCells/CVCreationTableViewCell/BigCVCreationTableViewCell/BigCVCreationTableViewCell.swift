//
//  BigCVCreationTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class BigCVCreationTableViewCell: CVCreationTableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    // MARK: - Parameters
    
    static let identifier: String = "BigCVCreationTableViewCell"
    
    // MARK: - Instance Methods
    
    override func configureWith(_ cv: UserCV, templateType: TemplateType, delegate: CVFieldCompletion) {
        super.configureWith(cv, templateType: templateType, delegate: delegate)
        typeLabel.text = templateType.name
        detailsTextView.text = cv.getValueForType(templateType)
        detailsTextView.delegate = self
    }
}

// MARK: - UITextViewDelegate

extension BigCVCreationTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let templateType = templateType else {
            return
        }
        
        delegate?.fieldUpdated(withText: textView.text, for: templateType)
    }
}
