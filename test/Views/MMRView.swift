//
//  MMRView.swift
//  test
//
//  Created by Alireza on 2023-08-18.
//
import SwiftUI
import CoreMotion
import UserNotifications
import RealmSwift

struct MMRView: View {
    @State private var mmrDuration: Double = 1
    @State private var maxIgnores: Int = 3
    @State private var isMMRActive: Bool = false
    @State private var lastMoveTime = Date()
    @State private var ignoreCount: Int = 0
    @State private var timer: Timer?
    @StateObject private var motion = MotionManager()
    
    func startTimer() {
        stopTimer()
        lastMoveTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            checkForMotion()
        }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        ignoreCount = 0
        lastMoveTime = Date()
    }
    
    var body: some View {
        Form {
            Section(header: Text("MMR Settings")) {
                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: $isMMRActive) {
                        Text("MMR Active")
                    }.onChange(of: isMMRActive) { newValue in
                        if newValue {
                            NotificationCenter.default.post(name: .init("startMMRTimer"), object: nil)
                        } else {
                            NotificationCenter.default.post(name: .init("stopMMRTimer"), object: nil)
                        }
                        NotificationCenter.default.post(name: .init("resetIgnoreCount"), object: nil)
                    }
                    
                    if isMMRActive {
                        VStack(alignment: .leading) {
                            Slider(value: $mmrDuration, in: 1...120, step: 1) {
                                Text("Duration")
                            }
                            Text("\(Int(mmrDuration)) minute(s)")
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            // TODO: chnaging the lower bound to 0
                            Stepper(value: $maxIgnores, in: 1...10) {
                                Text("Maximum Ignores: \(maxIgnores)")
                            }
                        }
                    }
                }
            }
                .onReceive(NotificationCenter.default.publisher(for: .init("startMMRTimer")), perform: { _ in
                    startTimer()
                })
                .onReceive(NotificationCenter.default.publisher(for: .init("stopMMRTimer")), perform: { _ in
                    stopTimer()
                })
                .onReceive(NotificationCenter.default.publisher(for: .init("resetIgnoreCount")), perform: { _ in
                    ignoreCount = 0
                })
                .onReceive(NotificationCenter.default.publisher(for: .init("resetForAccept")), perform: { _ in
                    ignoreCount = 0
                    lastMoveTime = Date()
                })
                .onReceive(NotificationCenter.default.publisher(for: .init("incrementIgnoreCount")), perform: { _ in
                    ignoreCount += 1
                })
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    func checkForMotion() {
        if !isMMRActive {
            timer?.invalidate()
            return
        }
        let timeSinceLastMove = Date().timeIntervalSince(lastMoveTime)
        let overalTime = Date().timeIntervalSince(lastMoveTime)
        print("Time since last move: \(Int(timeSinceLastMove)) seconds")
        
        if timeSinceLastMove <= 10 {
            if ignoreCount > 0 {
                if motion.hasMoved {
                    print("Motion detected, resetting timer.")
                    lastMoveTime = Date()
                    motion.hasMoved = false
                    ignoreCount = 0
                }
            }
        } else if timeSinceLastMove >= mmrDuration * 20 {
            if ignoreCount < maxIgnores {
                notifyUser()
                ignoreCount += 1
                print("ignoreCount < maxIgnores: ignoreCount: \(ignoreCount),  maxIgnores: \(maxIgnores)")
                lastMoveTime = Date()
            }
            if ignoreCount == maxIgnores {
                isMMRActive = false
                ignoreCount = 0
                timer?.invalidate()
                print("ignoreCount == maxIgnores: ignoreCount: \(ignoreCount),  maxIgnores: \(maxIgnores)")
            }
        }
        
    }
    
    func notifyUser() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "You've been stationary for \(Int(mmrDuration)) minutes. Move within 10 seconds to confirm MMR notification!"
        
        content.categoryIdentifier = "MOVE_CATEGORY"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    var hasMoved: Bool = false
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    init() {
        startMotionUpdates()
    }
    deinit {
        stopMotionUpdates()
    }
    func startMotionUpdates() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "MotionUpdates") { [weak self] in
            self?.endBackgroundTask()
        }
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else {
                if let error = error {
                    print("Motion updates error: \(error.localizedDescription)")
                    self?.restartMotionUpdates()
                }
                return
            }
            let previousX = self?.x ?? 0.0
            let previousY = self?.y ?? 0.0
            
            self?.x = motion.roll
            self?.y = motion.pitch
            
            if abs(motion.roll - previousX) > 0.5 || abs(motion.pitch - previousY) > 0.5 {
                self?.hasMoved = true
            }
        }
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
        endBackgroundTask()
    }
    
    private func restartMotionUpdates() {
        stopMotionUpdates()
        startMotionUpdates()
    }
    
    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
}

let notificationDelegate = NotificationDelegate()

func requestNotificationPermission() {
    let center = UNUserNotificationCenter.current()
    center.delegate = notificationDelegate
    
    let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION", title: "Accept", options: UNNotificationActionOptions(rawValue: 0))
    let ignoreAction = UNNotificationAction(identifier: "IGNORE_ACTION", title: "Ignore", options: .destructive)
    
    let moveCategory = UNNotificationCategory(identifier: "MOVE_CATEGORY", actions: [acceptAction, ignoreAction], intentIdentifiers: [], options: [])
    center.setNotificationCategories([moveCategory])
    
    center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        if granted {
            print("Notifications permission granted.")
        } else {
            print("Notifications permission denied because: \(error?.localizedDescription ?? "an error")")
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

struct MMRView_Previews: PreviewProvider {
    static var previews: some View {
        MMRView()
    }
}

