//
//  DetailView.swift
//  Scrumdinger
//
//  Created by nexsoft nexsoft on 18/04/22.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView(scrum: $scrum)){
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                
                
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minute")
                }.accessibilityElement(children: .combine)
                
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding()
                        .foregroundColor(.white)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }.accessibilityElement(children: .combine)
                
            }
            Section(header:Text("Attendees")){
                ForEach(scrum.attendees){
                    attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")){
                if(scrum.history.isEmpty){
                    Label("No Meetings yet", systemImage: "calendar.badge.exclamationmark")
                }else{
                    ForEach(scrum.history){
                        history in
                        NavigationLink(destination: HistoryView(history: history)) {
                            HStack{
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                        
                    }
                }
            }
        }   .navigationTitle(scrum.title)
            .toolbar{
                Button("Edit"){
                    isPresentingEditView = true
                    data = scrum.data
                }
            }
            .sheet(isPresented: $isPresentingEditView){ NavigationView{
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
                
            }
            }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
