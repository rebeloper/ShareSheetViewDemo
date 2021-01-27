//
//  ContentView.swift
//  ShareSheetViewDemo
//
//  Created by Alex Nagy on 27.01.2021.
//

import SwiftUI
import ShareSheetView

struct ContentView: View {
    
    @State private var isShareSheetViewPresented = false
    
    var body: some View {
        VStack(spacing: 12) {
            
            Button(action: {
                isShareSheetViewPresented = true
            }, label: {
                Text("Share")
            })
            .sheet(isPresented: $isShareSheetViewPresented, content: {
                ShareSheetView(activityItems: getActivityItems(), applicationActivities: getApplicationActivities(), excludedActivityTypes: getExcludedActivityTypes()) { (activityType, finished, activityItems, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    if let activityType = activityType {
                        print(activityType)
                    }
                    
                    print(finished)
                    
                    if let activityItems = activityItems {
                        print(activityItems)
                    }
                }
            })
            
            ShareSheetButton { () -> ShareSheetView in
                ShareSheetView(activityItems: getActivityItems())
            } label: { () -> AnyView in
                AnyView(
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                )
            }
            
            Spacer()
        }
        .padding()
    }
    
    func getActivityItems() -> [Any] {
        return ["Hello ShareSheetView"]
    }
    
    func getApplicationActivities() -> [UIActivity]? {
        return nil
    }
    
    func getExcludedActivityTypes() -> [UIActivity.ActivityType]? {
        return [.postToFacebook]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
