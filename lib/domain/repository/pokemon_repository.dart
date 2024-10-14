import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sample/domain/model/pokemon.dart';

part 'pokemon_repository.g.dart';

@riverpod
Future<List<Pokemon>> pokemonRepository(PokemonRepositoryRef ref) async {
  return getPokemonList();
}

Future<List<Pokemon>> getPokemonList() async {
  List<Pokemon> pokemonList = [];
  final api = "https://pokeapi.co/api/v2/pokemon?limit=9&offset=0";
  final response = await http.get(Uri.parse(api));

  List<dynamic> jsonDecodeResult = json.decode(response.body)["results"];

  print(jsonDecodeResult);

  for (var jsonDecode in jsonDecodeResult) {
    final url = await http.get(Uri.parse(jsonDecode["url"]));
    final urlDecode = json.decode(url.body);
    pokemonList.add(Pokemon.fromJson(
      {"name": jsonDecode["name"], "url": urlDecode["sprites"]["front_default"]},
    ));
  }

  return pokemonList;
}
