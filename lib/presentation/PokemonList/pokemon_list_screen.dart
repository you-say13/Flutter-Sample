import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/domain/repository/pokemon_repository.dart';

class PokemonListScreen extends ConsumerWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(context, ref) {
    final pokemonList = ref.watch(pokemonRepositoryProvider);
    Widget content;

    content = pokemonList.when(
      data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  ListTile(
                    leading: Image.network(
                      data[index].url,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint(error.toString());
                        return Text("取得失敗...");
                      },
                    ),
                    title: Text(data[index].name),
                  ),
                  const Divider(),
                ],
              )),
      error: (error, stack) {
        debugPrint("get List failed: ${error.toString()}");
        return Center(
          child: Text("failed"),
        );
      },
      loading: () => Center(
        child: const CircularProgressIndicator(),
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.sd_card,
          color: Colors.white,
        ),
        title: Text(
          "Pokemon",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 5,
        backgroundColor: Colors.green,
      ),
      body: content,
    );
  }
}
