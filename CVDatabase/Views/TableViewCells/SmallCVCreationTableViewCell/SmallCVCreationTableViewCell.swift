//
//  SmallCVCreationTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 04.12.2022.
//

import UIKit

class SmallCVCreationTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailsTextField: UITextField!
    
    // MARK: - Parameters
    
    static let identifier: String = "SmallCVCreationTableViewCell"
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
    
    // MARK: - IBActions
    
    @IBAction func editingDidChange(_ sender: Any) {
        guard let templateType = templateType else {
            return
        }
        
        delegate?.fieldUpdated(withText: detailsTextField.text ?? "", for: templateType)
    }
    
    // MARK: - Instance functions
    
    func configureWith(_ cv: UserCV, templateType: TemplateType) {
        typeLabel.text = templateType.name
        detailsTextField.text = cv.getValueForType(templateType)
        self.templateType = templateType
        
        if templateType == .phone {
            detailsTextField.keyboardType = .phonePad
        }
    }
}
