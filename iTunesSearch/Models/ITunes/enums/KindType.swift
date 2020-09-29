//
//  KindType.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum KindType: String, Codable {
    
    case book = "book"
    case album = "album"
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdf = "pdf"
    case podcast = "podcast"
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case song = "song"
    case tvEpisode = "tv-episode"
    case artistFor = "artistFor"
    
    
    var value: String {
        switch self {
        case .book:
            return "Book"
        case .album:
            return "Album"
        case .coachedAudio:
            return "Coached Audio"
        case .featureMovie:
            return "Feature Video"
        case .interactiveBooklet:
            return "Interactive Booklet"
        case .musicVideo:
            return "Music Video"
        case .pdf:
            return "PDF"
        case .podcast:
            return "Podcast"
        case .podcastEpisode:
            return "Podcast Episode"
        case .softwarePackage:
            return "Software Package"
        case .song:
            return "Song"
        case .tvEpisode:
            return "TV Episode"
        case .artistFor:
            return "Artist For"
        }
    }
}
