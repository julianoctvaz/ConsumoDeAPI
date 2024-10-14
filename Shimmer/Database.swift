//
//  Database.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//


let json = """

""".data(using: .utf8)!
//precisamosa garantir que o dado será devolvido, pois esse retorno é do tipo Data?

let jsonArray = """
[
    {
        "name_product": "Durian",
        "points": 600,
        "description": "A fruit with a distinctive scent."
    },
    {
        "name": "Apple",
        "points": 602
    }
]
""".data(using: .utf8)!


// { } nao é nulo, é um caso vazio! entao é preciso tratar tambem

let jsonArrayWithEmptyValues = """
[
    {
        "name_product": "Durian",
        "points": 600,
        "description": "A fruit with a distinctive scent."
    },
    { 
    },
    {
        "name_product": "Apple",
        "points": 602,
        "description": "Sweet and lovable"
    },
    {
        "name_product": "Lemon",
        "points": 603,
        "description": null
    },
    {
        "name_product": "Strawberry",
        "points": 604
    }
]
""".data(using: .utf8)!

