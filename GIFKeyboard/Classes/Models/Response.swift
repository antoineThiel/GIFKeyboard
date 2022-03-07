//
//  Response.swift
//  GIFKeyboard
//
//  Created by Anthony Jauch on 20/02/2022.
//

import Foundation

struct ResponseData: Decodable {
    let arrayReponseData: [Response]
   // let next: String
    private enum CodingKeys: String, CodingKey {
        case arrayReponseData = "results"
    }
}

struct Response: Decodable {
    let id: String
    let title: String
    let content_description: String
    let content_rating: String?
    let h1_title: String?
    let media: [Media]
    let bg_color: String?
    let created: Float
    let itemurl: String
    let url: String
    let tags: [String]?
    let flags: [String]?
    let shares: Int
    let hasaudio: Bool
    let hascaption: Bool
    let source_id: String
    
    private enum CodingKeys: String, CodingKey {
        case id, title, content_description, content_rating, h1_title,media,
        bg_color, created, itemurl, url, tags, flags, shares,hasaudio,hascaption,source_id
    }
}
