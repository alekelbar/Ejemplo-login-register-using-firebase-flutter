import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_firebase/models/pokemon_api.dart';
import 'package:login_firebase/widgets/Layout/layout.dart';
import 'package:http/http.dart' as http;

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool notFount = false;
  PokemonApi? pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de firebase')),
      drawer: const MyDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El nombre del pokemon es requerido';
                      }
                      return null;
                    },
                    controller: searchController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http.get(Uri.parse(
                          "https://pokeapi.co/api/v2/pokemon/${searchController.text}"));

                      if (response.statusCode != 200) {
                        setState(() {
                          notFount = true;
                        });
                        return;
                      }
                      try {
                        pokemon =
                            PokemonApi.fromJson(json.decode(response.body));

                        notFount = false;
                      } catch (e) {
                        print('error de red');
                      }
                      setState(() {});
                    }
                  },
                  child: const Icon(Icons.search),
                ),
                notFount || pokemon == null
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Pokemon not found',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : Card(
                        child: Column(
                          children: [
                            Image.network(pokemon!.sprites!.frontDefault!),
                            Center(
                              child: ListTile(
                                style: ListTileStyle.list,
                                title: Text(
                                  "${pokemon!.name}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Text(
                              "Abilities: ${pokemon!.abilities!.length}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
