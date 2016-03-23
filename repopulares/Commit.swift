//
//  Repository.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//


import Foundation
import GRDB


class Commit: Record {
    
    private var _idRepo: String
    private var _message: String
    
    var idRepo: String {
        get {
            return _idRepo
        }
        set {
            _idRepo = newValue
        }
    }
    
    var message: String {
        get {
            return _message
        }
        set {
            _message = newValue
        }
    }
    
    
    init(idRepo: String, message: String) {
        _idRepo = idRepo
        _message = message
        super.init()
    }
    
    // MARK: - Record
    
    override class func databaseTableName() -> String {
        return "commitbyrepo"
    }
    
    required init(_ row: Row) {
        _idRepo = row.value(named: "idRepo")
        _message = row.value(named: "message")
        super.init(row)
    }
    
    override var persistentDictionary: [String: DatabaseValueConvertible?] {
        return [
            "idRepo": _idRepo,
            "message": _message,
        ]
    }
    
}