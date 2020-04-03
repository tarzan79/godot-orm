extends Resource

#open database
#close database

#create collection
#select collection
#delete collection

#find model
#find_one model
#insert model
#update model
#delete model
#delete_all model

class_name Sql

const SQL = preload("res://lib/gdsqlite.gdns")
var PATH = "res://database/database.db"
var collection
var database

func _init():
    pass
    
func open(path):
    PATH = path
    
func close():
    pass
    
func select(from):
    collection = from
    return self
    
func create_collection(name, model):
    var q = "CREATE TABLE IF NOT EXISTS " + name + " (";
    q += "id integer PRIMARY KEY";
    for i in model:
        q += "," + i + " " + model[i] + " NOT NULL"
    q += ");";
    query(q)

func delete_collection():
    pass
    
func find_one(query):
    var index = 0
    var where = " WHERE "
    for i in query:
        if index < query.size() && query.size() > 1:
            where += i + "='" + query[i] + "' AND "
        else:
            where += i + "='" + query[i] + "'"
        index += 1
    var res = array("SELECT * FROM " + collection + where)
    return res[0]
    
func find(query):
    var index = 0
    if query.empty() == true:
        return array("SELECT * FROM " + collection)
    else:
        var where = " WHERE "
        for i in query:
            if index < query.size() && query.size() > 1:
                where += i + "='" + query[i] + "' AND "
            else:
                where += i + "='" + query[i] + "'"
            index += 1
        return array("SELECT * FROM " + collection + where)
    
func insert(data):
    var index = 1
    var query = "INSERT INTO " + collection
    var name = " ("
    var value = ") VALUES ("
    for i in data:
        if index < data.size():
            name += i + ", "
            value += "'" + str(data[i]) + "', "
        else:
            name += i
            value += "'" + str(data[i]) + "');"
        index += 1
    var res = query + name + value
    query(res)    
            
func update(id, data):
    var index = 1
    var value = "UPDATE " + collection
    value += " SET "
    for i in data:
        if index < data.size():
            value += index + " = '" + data[i] + "', "
        else:
            value += index + " = '" + data[i] + "' "
        index += 1
    value += "WHERE id='" + id + "'"
    query(value)
    
func delete(query):
    var index = 0
    var where = " WHERE "
    for i in query:
        if index < query.size() && query.size() > 1:
            where += i + "='" + query[i] + "' AND "
        else:
            where += i + "='" + query[i] + "'"
        index += 1
    query("DELETE FROM " + collection + where)   
    
func exec():
    pass


func _build_query():
    var query = ""
    pass

func test_db():
    var dir = Directory.new()
    var file = File.new()
    if !dir.dir_exists("res://game/database/"):
        dir.make_dir("res://game/database/")
    if !file.file_exists(PATH):
        file.open(PATH, File.WRITE)
        file.close()
    return true

func query(query):
    var db = SQL.new()
    db.open_db(PATH)
    var result = db.query(query)
    db.close()
#    print(str(result) + ":" + str(query))
    return result

func array(query):
    var db = SQL.new()
    db.open_db(PATH)
#    print(query)
    var list = db.fetch_array(query)
    db.close()
    return list

func count(query):
    var db = SQL.new()
    db.open_db(PATH)
    var list = db.fetch_array(query)
#    print(str(list[0]["COUNT(*)"]) + ":" + str(query))
    db.close()
    return list[0]["COUNT(*)"]
