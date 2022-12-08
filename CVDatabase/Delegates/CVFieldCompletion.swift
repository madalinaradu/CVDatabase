//
//  CVFieldCompletion.swift
//  CVDatabase
//
//  Created by Alexandra Radu on 07.12.2022.
//

import Foundation

protocol CVFieldCompletion: AnyObject {
    func fieldUpdated(withText text: String, for templateType: TemplateType)
}
