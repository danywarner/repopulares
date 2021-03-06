import GRDB

// The columns for the GRDB Query Interface
//
// See https://github.com/groue/GRDB.swift/#the-query-interface

//struct Col {
//    static let id = SQLColumn("id")
//    static let firstName = SQLColumn("firstName")
//    static let lastName = SQLColumn("lastName")
//}


// The shared database queue, stored in a global.
// It is initialized in setupDatabase()

var dbQueue: DatabaseQueue!

func setupDatabase() {
    
    // Connect to the database
    //
    // See https://github.com/groue/GRDB.swift/#database-queues
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
    let databasePath = documentsPath.stringByAppendingPathComponent("db.sqlite")
    dbQueue = try! DatabaseQueue(path: databasePath)
    
    
    // SQLite does not support Unicode: let's add a custom collation which will
    // allow us to sort persons by name.
    //
    // See https://github.com/groue/GRDB.swift/#string-comparison
    
    let collation = DatabaseCollation("localized_case_insensitive") { (lhs, rhs) in
        return (lhs as NSString).localizedCaseInsensitiveCompare(rhs)
    }
    dbQueue.addCollation(collation)
    
    
    // Use DatabaseMigrator to setup the database
    //
    // See https://github.com/groue/GRDB.swift/#migrations
    
    var migrator = DatabaseMigrator()
    migrator.registerMigration("createRepos") { db in
//        try db.execute(
//            "CREATE TABLE persons (" +
//                "id INTEGER PRIMARY KEY, " +
//                "firstName TEXT COLLATE localized_case_insensitive, " +
//                "lastName TEXT COLLATE localized_case_insensitive" +
//            ")")
        try db.execute("CREATE TABLE repository (" +
            "name TEXT PRIMARY KEY," +
            "starsNumber TEXT," +
            "forksNumber TEXT," +
            "avatarUrl TEXT," +
            "repoDescription TEXT," +
            "author TEXT," +
            "contributorsUrl TEXT," +
            "commitsUrl TEXT" +
            ")")
    }
    
    migrator.registerMigration("createCommits") { db in

        try db.execute("CREATE TABLE commitbyrepo (" +
            "idRepo TEXT NOT NULL," +
            "message TEXT" +
            ")")
    
    }
    
//    migrator.registerMigration("addPersons") { db in
//        try Person(firstName: "Arthur", lastName: "Miller").insert(db)
//        try Person(firstName: "Barbra", lastName: "Streisand").insert(db)
//        try Person(firstName: "Cinderella").insert(db)
//    }
    

    
    
    try! migrator.migrate(dbQueue)
}