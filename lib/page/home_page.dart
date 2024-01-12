import 'dart:convert';

import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final listArticles = <Article>[Article(nom: "voiture", image: "https://media.gqmagazine.fr/photos/653a6785b405923c6a3fe4ef/master/pass/SSC%20Tuatara.jpg", description: "C'est une belle voiture et elle coute vraiment pas cher."
      "", prix: 55, categorie: "categorie"), Article(nom: "Ordinateur", image: "https://media.gqmagazine.fr/photos/653a6785b405923c6a3fe4ef/master/pass/SSC%20Tuatara.jpg", description: "C'est bien un ordinateur mais qui n'a pas la bone catégorie, dommage que l'on ne le vois pas sur l'appli, on pourrais constater l'erreur."
      "", prix: 187599, categorie: "elecromenager")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("EPSI Shop"),
          actions: [
            IconButton(
                onPressed: ()=>context.go('/cart'),
                icon: Badge(
                  label: Text("${context.watch<Cart>().listArticles.length}"),
                    child: Icon(Icons.piano)
                )
            ),
            IconButton(
                onPressed: ()=>context.go('/aboutus'),
                icon: Icon(Icons.info_outline))
          ],
        ),
        body: FutureBuilder(
            future: fetchListProducts(),
            builder: (context, snapshot)=> switch (snapshot.connectionState){
              ConnectionState.done when snapshot.data != null =>
                  ListeArticles(listArticles: snapshot.data!),
                ConnectionState.waiting => CircularProgressIndicator(),
            _ => const Icon(Icons.error)
            })
    );
  }

  Future<List<Article>> fetchListProducts() async {
    String uri = "https://fakestoreapi.com/products";
    Response resListArt = await get(Uri.parse(uri));
    if (resListArt.statusCode == 200 && resListArt.body.isNotEmpty){
      final resListMap = jsonDecode(resListArt.body) as List<dynamic>;
      return resListMap
          .map<Article>((map)=> Article.fromMap(map as Map<String,dynamic>))
          .toList();
    } else {
      throw Exception("Requête invalide");
    }
  }
}

class ListeArticles extends StatelessWidget {
  const ListeArticles({
    super.key,
    required this.listArticles,
  });

  final List<Article> listArticles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listArticles.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: ()=>context.go("/details",extra: listArticles[index]),
          title: Text(listArticles[index].nom),
          leading: Image.network(listArticles[index].image),
          subtitle: Text(listArticles[index].getPrixEuro()),
          trailing: TextButton(
          child: Text("AJOUTER"),
          onPressed: () {
            context.read<Cart>().add(listArticles[index]);
          },
          )
        );
      },
    );
  }
}
