//
//  DailySleepFlowViewModel.swift
//  test
//
//  Created by david on 2023-08-19.
//

import Foundation
import SwiftUI

class DailySleepViewModel: ObservableObject {
    
    private let realm = Repository.shared.realm
    @Published var list: [DailySleepFlowData] = []
    
    func deleteByDate(bedTimeDay: Date) {
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: bedTimeDay)
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: bedTimeDay)!
        
        let sleepDataToDelete = realm.objects(DailySleepFlowData.self)
            .filter("bedTimeDateTime >= %@ AND bedTimeDateTime <= %@", startOfDay, endOfDay)
        do {
            try realm.write {
                realm.delete(sleepDataToDelete)
            }
        }catch {
            print(error)
        }
    }
    
    
    func addOrUpdate(_ item: DailySleepFlowData) {
        deleteByDate(bedTimeDay: item.bedTimeDateTime)
        add(item)
    }
    
    func add(_ item: DailySleepFlowData){
        do {
            try realm.write {
                realm.add(item)
            }
            getAll()
        }catch {
            print(error)
        }
    }
    
    func getAll() {
        let results = realm.objects(DailySleepFlowData.self).sorted(byKeyPath: "bedTimeDateTime", ascending: true)
        list = Array(results)
    }

}
