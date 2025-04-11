//
//  ModelContext.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 19/03/25.
//
import SwiftData

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
