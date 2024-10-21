//
//  Database.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//


let json = """
{
    "name_product": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!
//precisamosa garantir que o dado será devolvido, pois esse retorno é do tipo Data?

//Desafio 1
let jsonArray = """
[
    {
        "name_product": "Durian",
        "points": 600,
        "description": "A fruit with a distinctive scent."
    },
    {
        "name_product": "Apple",
        "points": 602
    }
]
""".data(using: .utf8)!


// { } nao é nulo, é um caso vazio! entao é preciso tratar tambem

//Desafio 2
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

