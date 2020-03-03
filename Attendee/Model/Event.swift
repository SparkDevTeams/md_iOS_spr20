//
//  NewEvent.swift
//  Attendee
//
//  Created by William Fernandez on 2/28/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import Foundation
 
class Event {
    
    private var eventID: String!
    private var eventName: String!
    private var eventDate: Date!
    private var eventDescription: String!
    private var eventHost: String!
    private var eventLocation: String!
    private var hasAttendanceLimit: Bool!
    private var organizationName: String?
    private var eventAttendanceLimit: Int?
    private var eventAttendees: [String]?
    private var eventQRCode: String?
    
    
    init(eventName: String!, eventDate: Date!, eventDescription: String!,
         eventHost: String!,
         eventLocation: String!, hasAttendanceLimit: Bool!, eventAttendanceLimit: Int?) {
        
        self.eventID = UUID().uuidString
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventDescription = eventDescription
        self.eventHost = eventHost
        self.eventLocation = eventLocation
        self.hasAttendanceLimit = hasAttendanceLimit
        
        if hasAttendanceLimit {
            self.eventAttendanceLimit = eventAttendanceLimit
        }
    }
}
