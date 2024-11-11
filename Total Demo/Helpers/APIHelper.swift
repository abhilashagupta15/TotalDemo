//
//  APIHelper.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import Foundation

struct APIHelper {
    public static let shared = APIHelper()
    private init(){}
    
    func loginApiCall(reqModel: LoginRequestModel) async -> LoginAPIHandler {
        guard let req = createPostReq(reqModel: reqModel) else {
            return .failure(err: .RequestCreationFailed)
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                return .failure(err: .InvalidStatusCode)
            }
            let obj = try JSONDecoder().decode(LoginResponseModel.self, from: data)
            print("response is \(obj)")
            return .success(obj: obj)
            
        } catch{
            return .failure(err: .APICallFailed)
        }
    }
    
    func getPostsApiCal(req: PostsRequestModel) async -> PostsAPIHandler {
        let req = createGetReq(reqModel: req)
        do {
            let (data, response) = try await URLSession.shared.data(for: req!)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                return .failure(err: .InvalidStatusCode)
            }
            
            let obj = try JSONDecoder().decode(OverallModel.self, from: data)
            print("response is \(obj)")
            return .success(obj: obj.posts)
        } catch {
            return .failure(err: .APICallFailed)
        }
    }
    
    private func createPostReq(reqModel: LoginRequestModel) -> URLRequest? {
        var req = URLRequest(url: URL(string: "https://dummyjson.com/auth/login")!)
        do {
            let body = try JSONEncoder().encode(reqModel)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            req.httpBody = body
        } catch {
            print(error)
        }
        return req
    }
    
    private func createGetReq(reqModel: PostsRequestModel) -> URLRequest? {
//        var req = URLRequest(url: URL(string: "https://dummyjson.com/users/\(reqModel.id)/posts")!)
        
        var req = URLRequest(url: URL(string: "https://dummyjson.com/users/5/posts")!)
        req.httpMethod = "GET"
        return req
    }
}


enum LoginAPIHandler {
    case success(obj: LoginResponseModel)
    case failure(err: APIError)
}

enum PostsAPIHandler {
    case success(obj: [PostsResponseModel])
    case failure(err: APIError)
}

enum APIError: String {
    case RequestCreationFailed
    case APICallFailed
    case InvalidStatusCode
}
//fetch('https://dummyjson.com/auth/login', {
//  method: 'POST',
//  headers: { 'Content-Type': 'application/json' },
//  body: JSON.stringify({
//
//    username: 'emilys',
//    password: 'emilyspass',
//    expiresInMins: 30, // optional, defaults to 60
//  }),
//  credentials: 'include' // Include cookies (e.g., accessToken) in the request
//})
//.then(res => res.json())
//.then(console.log);



//{
//  "id": 1,
//  "username": "emilys",
//  "email": "emily.johnson@x.dummyjson.com",
//  "firstName": "Emily",
//  "lastName": "Johnson",
//  "gender": "female",
//  "image": "https://dummyjson.com/icon/emilys/128",
//  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // JWT accessToken (for backward compatibility) in response and cookies
//  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // refreshToken in response and cookies
//}
