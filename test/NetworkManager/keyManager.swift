//
//  keyManager.swift
//  test
//
//  Created by david on 2023-08-15.
//

import Foundation

func getValueForKey(key: String) -> String? {
    if let plistPath = Bundle.main.path(forResource: "keys", ofType: "plist"),
       let plistXML = FileManager.default.contents(atPath: plistPath) {
        do {
            let plistData = try PropertyListSerialization.propertyList(from: plistXML, options: [], format: nil)
            if let plistDict = plistData as? [String: Any],
               let value = plistDict[key] as? String {
                return value
            }
        } catch {
            print("Error reading plist: \(error)")
        }
    }
    return nil
}
