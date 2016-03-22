//
//  Repository.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//


import Foundation


class Repository {
    
    private var _name: String
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
    
    
    init(name: String, avatarUrl: String, description: String, author: String, contributorsUrl: String, commitsUrl: String) {
        _name = name
        _avatarUrl = avatarUrl
        _repoDescription = description
        _author = author
        _contributorsUrl = contributorsUrl
        _commitsUrl = commitsUrl
    }
    
    
    
    
    
}