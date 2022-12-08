//
//  TemplateTypeTableViewCell.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 02.12.2022.
//

import UIKit

class TemplateTypeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var typeLabel: UILabel!
    
    // MARK: - Parameters
    
    static let identifier: String = "TemplateTypeTableViewCell"
    
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
    
    func configureWith(_ templateType: TemplateType, isSelected: Bool) {
        typeLabel.text = templateType.name
        
        self.backgroundColor = isSelected ? .green : .red
    }
}
