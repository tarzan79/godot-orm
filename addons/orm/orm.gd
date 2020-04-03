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
    "json": preload("res://addons/orm/json/json_file.gd")
}
var db
var type = ["sqlite", "mongodb", "json-file"] setget _set_type
    
func _init(type):
    _change_type(type)
    
func open(name):
    print(name)
    db.open(name)
    return self
    
func close():
    db.close()
    return self

func find_one(query):
    console.info("SELECT " + db.collection + " where : " + str(query))
    return db.find_one(query)
    
func find(query = {}):
    console.info("SELECT " + db.collection + " where : " + str(query))
    return db.find(query)
    
func count(query):
    return db.count(query)
    
func create_collection(name, schema):
    db.create_collection(name, schema)
    return self
    
func delete_collection(name):
    return db.delete_col(name)

func select(name): 
    db.select(name)
    return self
    
func delete(id):
    console.info("DELETE " + db.collection + " where : " + str(id))
    db.delete(id)

func delete_where(query):
    console.info("DELETE " + db.collection + " where : " + str(query))
    var res = db.find(query)
    for i in res:
        db.delete(res[i])
    pass
    
func insert(data):
    console.info("INSERT " + db.collection + " where : " + str(data))
    return db.insert(data)
    
func update(id, data):
    console.info("UPDATE " + db.collection + " where : id=" + id + " AND " + str(data))
    return db.update(id, data)
    
func _set_type(value):
    type = value
    _change_type(value)

func _change_type(value):
    print("change value")
    match value:
        "sqlite": db = database["sqlite"].new()
        "json": db = database["json"].new()
