import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data extends StatelessWidget {
  Future<List<Map<String, String>>> fetchPokemon() async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List results = data['results'];
      return results.map((pokemon) {
        return {
          'name': pokemon['name'] as String,
          'url': pokemon['url'] as String,
        };
      }).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchPokemon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Pokémon to show.'));
          }

          final pokemonList = snapshot.data!;

          return ListView.builder(
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              final name = pokemon['name']!;
              final imageUrl =
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png';
              return Column(
                children: [
                  ListTile(
                    leading: Image.network(imageUrl),
                    title: Text(
                      name.toUpperCase(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
