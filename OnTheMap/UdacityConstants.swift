//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Ada Ji on 11/18/15.
//  Copyright © 2015 Ada Ji. All rights reserved.
//

// MARK: - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        static let ParseAppID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr" // Parse Application ID
        static let ParseAPIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY" // Parse REST API Key
        static let FacebookAppID = "365362206864879" // Facebook App ID
        
        static let UdacityBaseURL: String = "https://www.udacity.com/api/"
        static let ParseBaseURL: String = "https://api.parse.com/1/classes/StudentLocation"
    }
    
    struct HTTPMethods {
        
        static let POST = "POST"
        static let GET = "GET"
        static let DELETE = "DELETE"
    }
    
    struct Methods {
        
        static let Session = "session"
        static let UsersId = "users/<user id>" // GETting Public User Data
    }
    
    struct ParameterKeys {
        
        // Get Student Locations (Optional)
        static let LimitKey = "limit" // (Number) specifies the maximum number of StudentLocation objects to return in the JSON response
        static let SkipKey = "skip" // (Number) use this parameter with limit to paginate through results
        static let OrderKey = "order" // (String) a comma-separate list of key names that specify the sorted order of the results
    }
    
    struct HTTPHeaderKeys {
        
        static let ParseAppIdKey = "X-Parse-Application-Id"
        static let ParseAPIKey = "X-Parse-REST-API-Key"
    }
    
    struct HTTPBodyKeys {
        
        // Udacity Auth
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
        // Facebook Auth
        static let FacebookMobile = "facebook_mobile"
        static let AccessToken = "access_token"
    }
    
    struct JSONResponseKeys {
        
        // Udacity Session
        
        static let Session = "session"
        
        static let ID = "id"
        
        // Student Location
        
        static let Results = "results"
        
        static let CreatedAt = "createdAt"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let UpdatedAt = "updatedAt"
    }
}