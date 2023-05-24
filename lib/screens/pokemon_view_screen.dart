import 'package:flutter/material.dart';
import 'package:pokedex_example/services/firebase_service.dart';
import 'package:pokedex_example/themes/apptheme.dart';
import 'package:pokedex_example/widgets/widgets.dart';

class PokemonViewScreen extends StatefulWidget {
   
  const PokemonViewScreen({Key? key}) : super(key: key);

  @override
  State<PokemonViewScreen> createState() => _PokemonViewScreenState();
}

class _PokemonViewScreenState extends State<PokemonViewScreen> {

  TextEditingController textEditingControllerNote = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    textEditingControllerNote.text = arguments['notes'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              PokemonServices().deletePokemon(arguments['uid']);
              PokemonServices().getPokemon();
              Navigator.popAndPushNamed(context, '/home');
            }, 
            icon: Icon(Icons.delete_outline_rounded)
          )
        ],
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        elevation: 0,
        title: Text('${arguments['number']} | ${arguments['name']}'),
      ),
      body: Column(
        children: [
          PokeCard(
            name: arguments['name'], 
            type1: arguments['type1'], 
            type2: arguments['type2'],
            image: arguments['image']
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Text('Irure voluptate eu adipisicing elit eiusmod anim nisi est anim magna ex dolor minim. Eu incididunt laboris incididunt ea cupidatat est laborum. Aliqua aliqua officia nulla aliqua exercitation proident commodo laboris ex proident.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Notes', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: TextField(
              controller: textEditingControllerNote,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              PokemonServices().updatePokemon(
              arguments['uid'], 
              arguments['image'], 
              arguments['name'], 
              textEditingControllerNote.text, 
              arguments['number'],
              arguments['type1'], 
              arguments['type2']
              );
              PokemonServices().getPokemon();
              Navigator.popAndPushNamed(context, '/home');
            },
            child: Text('Save'),
          )
        ],
      )
    );
  }
}