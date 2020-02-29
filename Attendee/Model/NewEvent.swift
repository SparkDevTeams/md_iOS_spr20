//
//  NewEvent.swift
//  Attendee
//
//  Created by William Fernandez on 2/28/20.
//  Copyright © 2020 SparkDev. All rights reserved.
//

import Foundation
 
struct NewEvent {
    var eventID: String!
    var eventName: String!
    var organizationName: String?
    var eventDate: Date!
    var eventHost: String?
    var eventDescription: String?
    var eventAttendanceLimit: Int?
    var eventAttendees: [String]?
    var eventQRCode: String?
    var location: String?
    
    init(name: String, date: Date) {
        eventID = UUID().uuidString
        eventName = name
        eventDate = date
    }
}
