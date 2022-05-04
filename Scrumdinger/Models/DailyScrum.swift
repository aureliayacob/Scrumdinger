//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by nexsoft nexsoft on 18/04/22.
//

import Foundation
struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title :String
    var attendees : [Attendee]
    var lengthInMinutes : Int
    var theme : Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum{
    
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        init(id: UUID = UUID(), name: String){
            self.id=id
            self.name=name
        }
    }
    
    struct Data { //stores the user edits
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5 //edit using slider view which is work with double value
        var theme: Theme = .bubblegum
    }
    
    var data : Data { //add a computed data property that returns Data with the DailyScrum property values.
        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .bubblegum),
        DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .lavender),
        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
    ]
}
