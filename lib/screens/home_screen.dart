import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex_example/models/pokemon_album.dart';
import 'package:pokedex_example/services/services.dart';
import 'package:pokedex_example/themes/apptheme.dart';
import 'package:pokedex_example/widgets/widgets.dart';


class HomeScreen extends StatefulWidget {
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pokemon>? pokemon;
  var isLoading = false;


  @override
  Widget build(BuildContext context) {

    Future refresh() async{
      setState(() {
        PokemonServices().getPokemon;
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/search');
            }, 
            icon: Icon(Icons.search_rounded)
          )
        ],
        centerTitle: true,
        backgroundColor: AppTheme.primary,
        elevation: 0,
        title: Text('My Pokédex'),
      ),
      body: FutureBuilder(
        future: PokemonServices().getPokemon(),
        builder: (context, snapshot){
            if (snapshot.hasData){
            return RefreshIndicator(
              onRefresh: refresh,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  
                  SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                      onLongPress: (){ 
                        Fluttertoast.showToast(msg: 'hi');
                      },
                      onTap: () {
                        Navigator.pushNamed(context, '/view', arguments: {
                          'uid': snapshot.data?[index]['uid'],
                          'name': snapshot.data?[index]['name'], 
                          'type1': snapshot.data?[index]['type1'], 
                          'type2': snapshot.data?[index]['type2'], 
                          'image': snapshot.data?[index]['image'],
                          'notes': snapshot.data?[index]['notes'],
                          'number': snapshot.data?[index]['number'.toString()]
                        });
                      },
                      child: PokeCard(
                        name: snapshot.data?[index]['name'], 
                        type1: snapshot.data?[index]['type1'],
                        type2: snapshot.data?[index]['type2'], 
                        image: snapshot.data?[index]['image'],
                      ),
                    );
                  },
                  childCount: snapshot.data?.length
                  ))
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}