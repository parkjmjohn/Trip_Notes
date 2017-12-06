//
//  NoteCell.swift
//  TripNotes
//
//  Created by John Park on 12/5/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: Spacing
    var padding1: CGFloat = 8
    var textSize: CGFloat = 16
    
    // MARK: UI
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // UI setup
        setUpLabel()
    }
    
    // MARK: label setup
    func setUpLabel() {
        label = UILabel(frame: CGRect(x: padding1, y: frame.height / 3, width: frame.width - padding1, height: textSize + 2))
        label.font = UIFont(name: "Futura-CondensedExtraBold", size: textSize)
        contentView.addSubview(label)
    }
    
    func setUpLabelTitle(city: City) {
        label.text = city.label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
