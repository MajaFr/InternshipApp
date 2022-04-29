//
//  MusicDetails.swift
//  InternshipApp
//
//  Created by Maja Frąk on 28/04/2022.
//

struct Music: Codable {
    let recordings: [Recording]
}

struct Recording: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case artistCredit = "artist-credit"
        case releases
    }
    
    let title: String
    let artistCredit: [ArtistCredit]
    let releases: [Release]
}

struct ArtistCredit: Codable {
    let name: String
}

struct Release: Codable {
    let title: String
}
