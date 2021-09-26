//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        bounds = bounds.inset(by: padding)
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        
        // header
        header.text = message.username
        header.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        header.textColor = UIColor(hexString: "#1B1E1F")
        
        // message
        body.text = message.text
        body.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        body.textColor = UIColor(hexString: "#1B1E1F")
        body.numberOfLines = 0
        body.layer.cornerRadius = 8
        body.layer.borderColor = UIColor(hexString: "#EFEFEF").cgColor
        body.layer.borderWidth = 1
        body.backgroundColor = .white
        
        
        // avatar
        if let url = message.avatarURL{
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                let image = UIImage(data: imageData)
                avatar.contentMode = .scaleAspectFit
                avatar.image = image
                avatar.layer.cornerRadius = avatar.frame.size.width / 2
                avatar.clipsToBounds = true
            }
        }
    }
}

@IBDesignable public class PaddingLable: UILabel{
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize{
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    
    
}
