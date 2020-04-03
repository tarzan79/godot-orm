extends Resource

class_name JsonFile

var exemple = {
    "user": {
        "increment": 0,
        "data": [{              #exemple.user.data[0] or exemple.user.find(data)
            "id": 1,
            "name": "truc",
            "mail": "machin"
        },{
            "id": 2,
            "name": "bidulle",
            "mail": "chouette"
        }]
       },
    "page": {
        "increment": 0,
        "data": [{
            "id": 1,
            "name": "tuto 1",
            "content": "blablabla"
        },{
            "id": 2,
            "name": "tuto 2",
            "content": "blablabla"
        }]
       }
   }

var PATH = "user://database/bdd.json"
var data = {}
var file
var collection = "" #or table
var zero:int = 0
var selected

func _init():
    pass

func open(_path):
    PATH = _path
    print(PATH)
    file = File.new()

    if not file.file_exists(PATH):
        print("fichier de données json inexistant")
        print("création du fichier")
        write()
        return

    if file.open(PATH, File.READ) != 0:
        print("Erreur pendant l'ouverture du fichier de données'")
        return
        
    var data_text = file.get_as_text()
    file.close()
    
    var res = JSON.parse(data_text)
    if res.error != OK:
        return
    data = res.result
    return self
    
func close():
    write()
    file.close()
    data = null

func write():
    var path = PATH
    file = File.new()
    if file.open(path, file.WRITE) != OK: return
    file.store_string(JSON.print(data))
    file.close()
    return self

#select a table or collection
func select(name):
    collection = name
    return self

func create_collection(name, col = {}):
    if not data.has(name): #if no exist only
        data[name] = {
            "increment": int(zero),
            "data": []
           }
    return self

func find(query):
    return _search(collection, query)


func find_one(value):
    return data[collection].data.find_last(value)

func delete(value):
    var res = data[collection].data.erase(value)
    write()
    return res

func insert(value):
    print("test")
    value["id"] = data[collection].increment
    var res = data[collection].data.append(value)
    data[collection].increment = value["id"] + 1
    write()
    return res

func update(id, value):
    #var id = data[collection].data.find_last(value)
    return self
    
func _search(col, query):
    var res = 0
    var tab = []
    
    for line in data[col].data: #on boucle sur chaque ligne de la collection
        print("line")
        print(line)
        res = 0
        for d in query: #pour chaque item, on verifie s'il possede toute les propriété et valeur de query
            if not line.has(d): #donc deja si y'a pas la propriété c'est mort
                res = -1
                break
                if not line[d] == query[d]: #et si y'a pas non plus la bonne valeur, c'est mort aussi
                    res = -1
        if res == 0:
            tab.append(line)
    return tab
                
func get_col():
    return collection

func exec():
    pass

func _join(d1, d2):
    for i in d2:
        d1[i] = d2[i]
    return d1
