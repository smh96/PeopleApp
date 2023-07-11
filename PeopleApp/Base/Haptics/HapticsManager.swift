//
//  HapticsManager.swift
//  PeopleApp
//
//  Created by Sander Haug on 10/07/2023.
//

import Foundation
import UIKit

fileprivate final class HapticManager {
    
    static let shared = HapticManager()
    
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticEnabled) {
        HapticManager.shared.trigger(notification)
    }
}
