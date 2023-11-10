//
//  AchivmenteGameCenter.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 07/11/23.
//

import Foundation
import SwiftUI
import GameKit


struct GameCenterView: View {

    @State var count: Int = 0

    func record () {
        self.count += 1
    }

// Ranking
    func saveGameCenterLeaderboard (record: Int) {
           let local = GKLocalPlayer.local
           if GKLocalPlayer.local.isAuthenticated {
               GKLeaderboard.submitScore(record, context: 0, player: local, leaderboardIDs: ["Conquistou o Olimpo"], completionHandler: { error in
                   if error != nil {
                       print(error!)
                   } else {
                       print("Score \(record) submitted")
                   }
               })
           } else {
               print("User not sign into Game Center")
           }
       }
// Conquista
    func saveAchievements(achievementID: String, titleMessage: String, message: String) {
        GKAchievement.loadAchievements(completionHandler: { (achievements: [GKAchievement]?, error: Error?) in

            print(achievementID, achievements?.count, error)
            let achievementID = achievementID
            var achievement: GKAchievement?
            achievement = achievements?.first(where: { $0.identifier == achievementID})
            if achievement == nil {
                achievement = GKAchievement(identifier: achievementID)
            }

            achievement?.percentComplete = 100
            if error != nil {
                print("Error: \(String(describing: error))")
            }

            let achievementsToReport: [GKAchievement] = [achievement!]

            achievement?.showsCompletionBanner = true
            GKNotificationBanner.show(withTitle: titleMessage,
                                      message: message,
                                      completionHandler: nil)
            GKAchievement.report(achievementsToReport, withCompletionHandler: {(error: Error?) in
                if error != nil {
                    print("Error: \(String(describing: error))")
                }
            })
        })
    }

    var body: some View {
        NavigationView {

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameCenterView()
    }
}
