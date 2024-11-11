//
//  LoginDataModels.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import Foundation

struct LoginRequestModel: Encodable {
    var username: String
    var password: String
    var expiresInMins: Int = 30
}

struct LoginResponseModel: Decodable{
    var id: Int
    var username: String
    var email: String
    var firstName: String
    var lastName: String?
    var gender: Gender
    var image: String
//    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // JWT accessToken (for backward compatibility) in response and cookies
//    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // refreshToken in response and cookies
}

enum Gender: String, Decodable {
    case F = "female"
    case M = "male"
}
