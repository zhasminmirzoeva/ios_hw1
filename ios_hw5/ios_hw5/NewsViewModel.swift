//
//  NotesViewModel.swift
//  ios_hw5
//
//  Created by Zhasmin Mirzoeva on 27.11.2022.
//

import UIKit
final class NewsViewModel {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data? = nil
    init(title: String, description: String, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}

