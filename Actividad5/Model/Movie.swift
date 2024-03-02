//
//  Film.swift
//  Actividad5
//
//  Created by Luciano Blanco 2/3/24.
//

import Foundation

struct Movie: Codable {
    let page: Int
    let results: [Result]
    let total_pages, total_results: Int
}

struct Result: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path, release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

