//
//  NoteCell.swift
//  TripNotes
//
//  Created by John Park on 11/29/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    //MARK: Spacing
    let padding1: CGFloat = 8
    let textSize: CGFloat = 16.0
    
    //debug: Xcode wont let me call this description
    // MARK: UI
    var title: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title = UILabel(frame: CGRect(x: padding1, y: padding1, width: 200, height: textSize + padding1 / 2))
        title.font = UIFont(name: "HelveticaNeue-Bold", size: textSize)
        contentView.addSubview(title)
    }
    
    func setupCell(city: City) {
        title.text = city.description
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
