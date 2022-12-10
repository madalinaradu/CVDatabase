//
//  CVCreationTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 10.12.2022.
//

import UIKit

protocol CVCreationTableViewCellType {
    func configureWith(_ cv: UserCV, templateType: TemplateType, delegate: CVFieldCompletion)
}

class CVCreationTableViewCell: UITableViewCell, CVCreationTableViewCellType {
    
    // MARK: - Parameters
    
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
    
    // MARK: - Instance Methods
    
    func configureWith(_ cv: UserCV, templateType: TemplateType, delegate: CVFieldCompletion) {
        self.templateType = templateType
        self.delegate = delegate
    }
}
