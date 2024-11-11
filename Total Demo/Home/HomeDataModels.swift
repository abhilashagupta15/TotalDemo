//
//  HomeDataModels.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import Foundation

struct PostsRequestModel {
    var id: Int
}

struct OverallModel: Decodable {
    var posts: [PostsResponseModel]
    var total: Int
    var skip: Int
}
struct PostsResponseModel: Decodable {
    var id: Int
    var title: String
    var reactions: Reactions
}

struct Reactions: Decodable {
    var likes: Int
    var dislikes: Int
}

//{
//  "posts": [
//    {
//      "id": 61,
//      "title": "I'm going to hire professional help tomorrow.",
//      "body": "I'm going to hire professional help tomorrow. /*... more data */  ",
//      "userId": 5, // user id is 5
//      "tags": [
//      "fiction"
//        "classic"
//        "american"
//      ],
//      "reactions": {
//        "likes": 1127,
//        "dislikes": 40
//      }
//    },
//    {...}
//  ],
//  "total": 2,
//  "skip": 0,
//  "limit": 2
//}
