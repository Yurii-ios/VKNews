//
//  UserResponse.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 08/11/2020.
//

import UIKit

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
