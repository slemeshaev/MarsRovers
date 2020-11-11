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
    let camera: [Camera]
    let img_src: String
    let earth_date: String
    let rover: [Rover]
}

struct Camera: Decodable {
    let id: Int
    let name: String
    let rover_id: Int
    let full_name: String
}

struct Rover: Decodable {
    let id: Int
    let name: String
}
