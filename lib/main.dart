import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_example/firebase_options.dart';
import 'package:pokedex_example/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Pokédex',
      initialRoute: '/home',
      routes: {
        '/home': (_) =>  const HomeScreen(),
        '/search': (_) =>  const SearchScreen(),
        '/view': (_) =>  const PokemonViewScreen(),
      },
    );
  }
}