import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/cart.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("${article.nom}"),
      actions: [
        IconButton(
            onPressed: ()=>context.go('/cart'),
            icon: Badge(
                label: Text("${context.watch<Cart>().listArticles.length}"),
                child: Icon(Icons.piano)
            )
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(article.image, height: 300.0),
          Text(
            article.nom,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            article.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          Text(
            article.getPrixEuro(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () => context.read<Cart>().add(article),
              child: const Text("Ajouter au panier")
          )
        ],
      ),
    ),
  );
}
  
  