//
//  BigCVCreationTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class BigCVCreationTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    // MARK: - Parameters
    
    static let identifier: String = "BigCVCreationTableViewCell"
    weak var delegate: CVFieldCompletion?
    var templateType: TemplateType?
    
    // MARK: - Lifecycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Instance functions
    
    func configureWith(_ cv: UserCV, templateType: TemplateType) {
        typeLabel.text = templateType.name
        detailsTextView.text = cv.getValueForType(templateType)
        self.templateType = templateType
    }
    
}

extension SmallCVCreationTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let templateType = templateType else {
            return
        }
        
        delegate?.fieldUpdated(withText: textView.text, for: templateType)
    }
}
