//
//  ExerciseCell.swift
//  LiftTracker
//
//  Created by Peisen Xue on 7/29/17.
//  Copyright © 2017 Peisen Xue. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var repLabel: UILabel!
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var exerciseLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        changeCellFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeCellFont() {

        let cellFont = UIFont(name: "SFProDisplay-Thin", size: 30)
        
        self.exerciseLabel.font = cellFont
        self.setLabel.font = cellFont
        self.repLabel.font = cellFont
        self.weightLabel.font = cellFont
    }

}
