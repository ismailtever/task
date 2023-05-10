//
//  TaskTableViewCell.swift
//  ios
//
//  Created by Ismail Tever on 3.05.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coloredCircle: UIImageView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
