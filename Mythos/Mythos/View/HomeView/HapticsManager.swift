//
//  HapticsManager.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 18/10/23.
//

import Foundation
import SwiftUI

final class HapticsManager {

    static let shared = HapticsManager()

    private init() {}

    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }

    }

    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
