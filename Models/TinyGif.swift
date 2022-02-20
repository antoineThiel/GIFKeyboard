//
//  TinyGif.swift
//  GIFKeyboard
//
//  Created by Anthony Jauch on 20/02/2022.
//

import Foundation

struct TinyGif: Decodable {
    let size: Int
    let url: String
    let dims: [Int]
    let preview: String
    
    private enum CodingKeys: String, CodingKey {
        case size,url,dims,preview
    }
}
