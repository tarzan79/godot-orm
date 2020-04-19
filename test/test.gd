extends Node

# une url
# une base
# une table/collection


func _ready():
    test_sqlite()
#    var jf := JSONFile.new()
#    jf.schema_validator = JSONSchema.new()
#    jf.json_schema = to_json(some_schema_dictionary)
#    jf.open("user://some_data.txt", File.WRITE)
#    my_data = jf.load_data() #if my_data turned to String, check if it is error message
#    jf.close()
#    var zz = load("res://addons/rpg_editor/model/user.gd").new()
#    var validator = JSONSchema.new()
#    var data = {"name": "text"}
#    var res = validator.validate(JSON.print(data), JSON.print(zz.schema))
#    print("res =>")
#    if res == "":
#        print("popopopopopo")

func test_sqlite():
    var db = Orm.new("sqlite")
    
    
    db.open({
        "file": "user://database.db"
    })
    db.create_collection("Books", {
        "Name": "String"
    })
    
    db.select("Books")

    db.insert_one({
        "Name": "lalala"
    })
    
    print(db.find_one({
        "Name": "lalala"
    }))

func test_mongodb():
    var db = Orm.new("mongodb")
    
    
    db.open({
        "url": "127.0.0.1",
        "port": "27017",
        "base": "test",
        "user": "grognon",
        "password": "azerty"
    })

    db.select("Books")
    print(db.find_one({
        "Name": "lalala"
    }))
