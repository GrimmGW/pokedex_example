import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex_example/models/pokemon_album.dart';
import 'package:pokedex_example/services/services.dart';
import 'package:pokedex_example/themes/apptheme.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_example/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
   
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  late Pokemon pokemonSearch;
  bool searchOn = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primary,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: (value) {
                searchPokemon();
              },
              decoration: InputDecoration(
                hintText: 'Name or Pokémon ID',
                prefixIcon: Icon(Icons.search, color: AppTheme.primary,), 
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          const Icon(Icons.help_outline_sharp, color: Colors.grey, size:50,),
          Container(
            margin: const EdgeInsets.symmetric(vertical:10, horizontal: 50),
            child: Text('Here you can search any Pokémon to be added in My Pokédex.'),
          ),
          if (searchOn == true)
            PokeCard(
            name: pokemonSearch.name, 
            type1: pokemonSearch.types[0].type.name, 
            type2: pokemonSearch.types.length == 2 ? pokemonSearch.types[1].type.name : '', 
            image: pokemonSearch.sprites.other!.officialArtwork.frontDefault
          ),
          if (searchOn == true)
          MaterialButton(
            onPressed: (){
              PokemonServices().addPokemon(
                pokemonSearch.sprites.other!.officialArtwork.frontDefault, 
                pokemonSearch.name,
                '', 
                pokemonSearch.id, 
                pokemonSearch.types[0].type.name,
                pokemonSearch.types.length == 2 ? pokemonSearch.types[1].type.name : ''
              );
              PokemonServices().getPokemon();
              Navigator.popAndPushNamed(context, '/home');
            },
            child: Text('Add to My Pokédex'),
          )
        ],
      ) 
    );
  }
  Future<void> searchPokemon() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${controller.text.toLowerCase()}'));

    if (controller.text != ''){
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        setState(() {
          pokemonSearch = Pokemon.fromJson(jsonDecode(response.body));
          searchOn = true;
        });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        Fluttertoast.showToast(msg: 'No encontrado');
      }
    } else {
      Fluttertoast.showToast(msg: 'No encontrado2');
    }
  }
}