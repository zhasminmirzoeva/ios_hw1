//
//  NoteCell.swift
//  ios_hw4
//
//  Created by Zhasmin Mirzoeva on 20.11.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    private var textlabel = UILabel()
    var delegate: AddNoteDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func setupView() {
        textlabel.font = .systemFont(ofSize: 16, weight: .regular)
        textlabel.textColor = .label
        textlabel.numberOfLines = 0
        textlabel.backgroundColor = .clear
        self.contentView.backgroundColor = .secondarySystemBackground
        self.contentView.addSubview(textlabel)
        textlabel.pinLeft(to: self.contentView, 16)
        textlabel.pinRight(to: self.contentView, 16)
        textlabel.pinTop(to: self.contentView, 16)
        textlabel.pinBottom(to: self.contentView, 16)
    }
    public func configure(_ note: ShortNote) {
        textlabel.text = note.text
    }
}

