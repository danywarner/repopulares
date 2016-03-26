//
//  Repository.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//


import Foundation
import GRDB


class Repository: Record {
    
    private var _name: String
    private var _starsNumber: String
    private var _forksNumber: String
    private var _avatarUrl: String
    private var _repoDescription: String
    private var _author: String
    private var _contributorsUrl: String
    private var _commitsUrl: String
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var forksNumber: String {
        get {
            return _forksNumber
        }
        set {
            _forksNumber = newValue
        }
    }
    
    var starsNumber: String {
        get {
            return _starsNumber
        }
        set {
            _starsNumber = newValue
        }
    }
    
    var repoDescription: String {
        get {
            return _repoDescription
        }
        set {
            _repoDescription = newValue
        }
    }
    
    var author: String {
        get {
            return _author
        }
        set {
            _author = newValue
        }
    }
    
    var avatarUrl: String {
        get {
            return _avatarUrl
        }
        set {
            _avatarUrl = newValue
        }
    }
    
    var contributorsUrl: String {
        get {
            return _contributorsUrl
        }
        set {
            _contributorsUrl = newValue
        }
    }
    
    var commitsUrl: String {
        get {
            return _commitsUrl
            
        }
        set {
            _commitsUrl = newValue
        }
    }
    
    init(name: String, starsNumber: String, forksNumber: String, avatarUrl: String, description: String, author: String, contributorsUrl: String, commitsUrl: String) {
        _name = name
        _forksNumber = forksNumber
        _starsNumber = starsNumber
        _avatarUrl = avatarUrl
        _repoDescription = description
        _author = author
        _contributorsUrl = contributorsUrl
        _commitsUrl = commitsUrl
        super.init()
    }
    
    // MARK: - Record
    
    override class func databaseTableName() -> String {
        return "repository"
    }

    required init(_ row: Row) {
        _name = row.value(named: "name")
        _starsNumber = row.value(named: "starsNumber")
        _forksNumber = row.value(named: "forksNumber")
        _avatarUrl = row.value(named: "avatarUrl")
        _repoDescription = row.value(named: "repoDescription")
        _author = row.value(named: "author")
        _contributorsUrl = row.value(named: "contributorsUrl")
        _commitsUrl = row.value(named: "commitsUrl")
        super.init(row)
    }
    
    override var persistentDictionary: [String: DatabaseValueConvertible?] {
        return [
            "name": _name,
            "starsNumber": _starsNumber,
            "forksNumber": _forksNumber,
            "avatarUrl": _avatarUrl,
            "repoDescription": _repoDescription,
            "author": _author,
            "contributorsUrl": _contributorsUrl,
            "commitsUrl": _commitsUrl
        ]
    }
    
}