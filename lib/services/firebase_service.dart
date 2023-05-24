import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_example/models/pokemon_album.dart';

class PokemonServices extends ChangeNotifier{

  FirebaseFirestore db =  FirebaseFirestore.instance;
  late Pokemon selectedPokemon;

  Future<List> getPokemon() async {
    List pokemon = [];
    CollectionReference collectionReferencePokemon = db.collection('pokemon');
    QuerySnapshot queryPokemon = await collectionReferencePokemon.orderBy('number', descending: false).get();
    for (var doc in queryPokemon.docs){
      final Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
      final pokemonMap = {
        'name': data['name'], 
        'type1': data['type1'], 
        'type2': data['type2'], 
        'image': data['image'],
        'notes': data['notes'],
        'number': data['number'],
        'uid': doc.id
      };
      pokemon.add(pokemonMap);
    }
    notifyListeners();
    return pokemon;
  }

  Future<void> addPokemon(String image, String name, String notes, int number, String type1, String type2) async {
    CollectionReference collectionReferencePokemon = db.collection('pokemon');
    await collectionReferencePokemon.add({'image': image, 'name': name, 'notes': notes, 'number': number, 'type1': type1, 'type2': type2});
  }

  Future<void> updatePokemon(String uid,  String image, String name, String newNotes, int number, String type1, String type2) async {
    await db.collection('pokemon').doc(uid).set({'image': image, 'name': name,"notes": newNotes, 'number': number, 'type1': type1, 'type2': type2});
  }

  Future<void> deletePokemon(String uid) async {
    await db.collection('pokemon').doc(uid).delete();
  }

}