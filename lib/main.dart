import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokeybellz/pokemon.dart';
import 'package:pokeybellz/pokemondetail.dart';


void main() => runApp(MaterialApp(
  title: "Poke App",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PokeyBellz Reference App"),
        backgroundColor: Colors.blueGrey,

      ),
      body: pokeHub == null?Center(child: CircularProgressIndicator(),)
          : GridView.count(crossAxisCount: 2,children: pokeHub.pokemon.map((poke)=> Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
              pokemon: poke,
            )));
          },
          child: Hero(
            tag: poke.img,
            child: Card(
              elevation: 4.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poke.img)),
                    ),
                  ),
                  Text(poke.name, style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold
                  ),),
                ],
              )
            ),
          ),
        ),
      ))
          .toList(),),

      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(onPressed: (){},
        backgroundColor: Colors.blueGrey, child: Icon(Icons.refresh),
      ),
    );
  }
}
