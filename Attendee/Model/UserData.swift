//
//  UserData.swift
//  Attendee
//
//  Created by William Fernandez on 2/28/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import Foundation

class UserData {
    private var userID: String!
    private var firstName: String!
    private var lastName: String!
    private var email: String!
    private var password: String!
    private var isOrganization: Bool!
    private var organizationName: String?
    private var hostedEvents: [String]?
    private var attendedEvents: [String]?
    private var isHosting: Bool?
    private var avatarURL: String?
    
    init(firstName: String, lastName: String, email: String, password: String, isOrganization: Bool) {
        self.userID = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.isOrganization = isOrganization
    }
    
    func getUserID() -> String! {
        return self.userID
    }
    func getFirstName() -> String! {
        return self.firstName
    }
    func getLastname() -> String! {
        return self.lastName
    }
    func getEmail() -> String! {
        return self.email
    }
    func getPassword() -> String! {
        return self.password
    }
    
    func getOrganizationName() -> String? {
        if isOrganization {
            return self.organizationName
        } else {
            return self.firstName + self.lastName
        }
    }
    func getHostedEvents() -> [String]? {
        return self.hostedEvents
    }
    func getAttendedEvents() -> [String]? {
        return self.attendedEvents
    }
    func getAvatarURL() -> String? {
        return self.avatarURL
    }
    
    
}
