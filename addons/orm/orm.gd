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

class_name Orm
var database = {
    "sqlite": preload("res://addons/orm/sqlite/sqlite.gd"),
    "json": preload("res://addons/orm/json/json_file.gd"),
    "mongodb": preload("res://addons/orm/mongodb/mongodb.cs")
}
var db
var type = ["sqlite", "mongodb", "json-file"] setget _set_type
    
func _init(type: String):
    _change_type(type)
    

func open(credential: Dictionary) -> void:
    print(credential)
    db.open(credential)
    

func close() -> void:
    db.close()


func create_collection(name: String, schema = {}) -> void:
    db.create_collection(name, schema)
    

func delete_collection(name: String):
    return db.delete_col(name)


#cette fonction est chainable
func select(name: String) -> Object: 
    db.select(name)
    return self


func count(query: Dictionary) -> int:
    return db.count(query)


func insert_one(data: Dictionary) -> bool:
    #print("INSERT " + db.collection + " where : " + str(data))
    return db.insert_one(data)


func insert_many(data: Array) -> bool:
    return false


func find_one(query: Dictionary) -> Dictionary:
    print(db.collection)
    print(str(query))
    print("SELECT " + db.collection + " where : " + str(query))
    return db.find_one(query)
    

func find(query = {}) -> Array:
    print("SELECT " + db.collection + " where : " + str(query))
    return db.find(query)


func update_one(id: int, data: Dictionary):
    print("UPDATE " + db.collection + " where : id=" + id + " AND " + str(data))
    return db.update(id, data)
    

func update_many(query: Dictionary, data: Dictionary):
    return db.update(query, data)


func delete_by_id(id: int):
    print("DELETE " + db.collection + " where : " + str(id))
    db.delete({
        "id": id
    })


func delete(query: String):
    print("DELETE " + db.collection + " where : " + str(query))
    db.delete(query)


func _set_type(value: String):
    type = value
    _change_type(value)


func _change_type(value: String):
    print("change value")
    match value:
        "sqlite": db = database["sqlite"].new()
        "json": db = database["json"].new()
        "mongodb": db = database["mongodb"].new()

static func migrate(from: Orm, to: Orm, collection: String):
    var origin = from.find({})
    to.create_collection(collection)
    to.insert_many(origin)
