//
//  RoverSnapshot.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 10.11.2020.
//

import Foundation

struct SnapshotsResults: Decodable {
    let photos: [RoverSnapshot]
}

struct RoverSnapshot: Decodable {
    let id: Int
    let img_src: String
    let earth_date: String
    let rover: [Rover]
}

struct Rover: Decodable {
    let id: Int
    let name: String
}
