using Godot;
using System;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Collections.Generic;
using MongoDB.Bson.Serialization;

// #open database
// #close database

// #create collection
// #select collection
// #delete collection

// #find model          x
// #find_one model      x
// #insert model        x
// #update model        x
// #delete model        x
// #delete_all model

public class mongodb : Godot.Object
{

    // private int a = 2;
    // private string b = "text";
    private MongoClient _mongo;
    private IMongoDatabase _database;
    private IMongoCollection<BsonDocument> _collection;

    public string collection;    // the Name property


    public void open(Godot.Collections.Dictionary<string, string> url){
        var mongoUrl = "mongodb://" + url["url"];
        _mongo = new MongoClient(mongoUrl);
        _database = _mongo.GetDatabase(url["base"]);
    }

    public void select(String name){
        _collection = _database.GetCollection<BsonDocument>(name);
        collection = name;
    }

    public Godot.Collections.Array find(Godot.Collections.Dictionary query){
        var res = new Godot.Collections.Array();
        var trucTrouve = _collection.Find(query.ToJson()).ToList();
        foreach(var unTruc in trucTrouve){
            unTruc["_id"] = unTruc["_id"].ToString();
            var t = BsonSerializer.Deserialize<Godot.Collections.Dictionary>(unTruc); //par contre la, ca provoque une erreur
            res.Add(t);
        }
        return res;
    }

    public Godot.Collections.Dictionary find_one(Godot.Collections.Dictionary query){
        var res = new Godot.Collections.Dictionary();
        var trucTrouve = _collection.Find(query.ToJson()).FirstOrDefault();
        trucTrouve["_id"] = trucTrouve["_id"].ToString();
        res = BsonSerializer.Deserialize<Godot.Collections.Dictionary>(trucTrouve);
        return res;
    }

    public void insert_one(Godot.Collections.Dictionary data){
        var item = new BsonDocument(data);
        _collection.InsertOne(item);
    }

    public void insert_many(Godot.Collections.Array data){

    }

    public void update(Godot.Collections.Dictionary query, Godot.Collections.Dictionary data){
        var updateData = new BsonDocument(data);
        GD.Print(updateData);
        var res = _collection.UpdateOne(query.ToJson(), "{$set: " + updateData + "}");
    }

    public void delete(Godot.Collections.Dictionary query){
        _collection.DeleteOne(query.ToJson());
    }
}
