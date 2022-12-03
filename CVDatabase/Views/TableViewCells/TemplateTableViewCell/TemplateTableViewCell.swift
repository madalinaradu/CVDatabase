//
//  TemplateTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class TemplateTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var componentsLabel: UILabel!
    
    // MARK: - Parameters
    
    static let identifier: String = "TemplateTableViewCell"
    
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
    
    func configureWith(_ template: Template) {
        typeLabel.text = "Template"
        
        componentsLabel.text = template.components
    }
}
