//
//  Cat.swift
//  Shimmer
//
//  Created by Juliano on 14/10/24.
//
import Foundation

//Codable = Encodable + Decodable

struct Cat: Codable { //Model //Reponse
    let data: [String]
}

//nao precisamos usar o codingKeys se nao acharmos necessario
