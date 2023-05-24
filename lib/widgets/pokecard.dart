import 'package:flutter/material.dart';

class PokeCard extends StatelessWidget {

  final String name;
  final String type1;
  final String? type2;
  final String image;

  const PokeCard({
    super.key, 
    required this.name, 
    required this.type1, 
    this.type2, 
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Colors.green.shade200,
              Colors.white
            ]
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  type2 == ''
                  ?  Text(type1)
                  :  Text('$type1/$type2')
                ],
              ),
            ),
            Container(
              child: FadeInImage(
                image: NetworkImage(image),
                placeholder: AssetImage('assets/pokeloading.gif'),
              ),
            )
          ],
        ),
      ),
    );
  }
}