//
//  Media.swift
//  GIFKeyboard
//
//  Created by Anthony Jauch on 20/02/2022.
//

import Foundation

struct ResponseMedia: Decodable {
    let arrayMedia: [Media]
    private enum CodingKeys: String, CodingKey {
        case arrayMedia = "media"
    }
}

struct Media: Decodable {
    let tinygif: TinyGif
    
    private enum CodingKeys: String, CodingKey {
        case tinygif
    }
}
