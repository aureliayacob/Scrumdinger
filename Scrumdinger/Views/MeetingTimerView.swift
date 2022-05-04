//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by nexsoft nexsoft on 29/04/22.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    let isRecording: Bool
    
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay  {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bebe", isCompleted: true), ScrumTimer.Speaker(name: "Bubu", isCompleted: true),
         ScrumTimer.Speaker(name: "Bibi", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers, theme: .lavender, isRecording: true)
    }
}
    
