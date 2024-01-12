import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../bo/article.dart';
import '../bo/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          )
        ],
      ),
      body: Consumer<Cart>(
        builder: (BuildContext context, Cart cart, Widget? child) {
        return cart.listArticles.isEmpty ?
        EmptyCart() : ListCart(listArticles: cart.listArticles, prixEuro: cart.getTotalPrice(), intPrixEuro: cart.getIntTotalPrice());
      },),

      );
  }
}

class ListCart extends StatelessWidget {
  final List<Article> listArticles;
  final String prixEuro;
  // j'ai créer cette variable pour retourner le prix en int pour gérer la TVA
  final int intPrixEuro;

  const ListCart({super.key, required this.listArticles, required this.prixEuro, required this.intPrixEuro});

  @override
  Widget build(BuildContext context) =>  Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Votre panier total est de :"),
            Text(prixEuro, style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        Flexible(
          child: ListView.builder(
                  itemCount: listArticles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(listArticles[index].nom),
                        leading: Image.network(listArticles[index].image),
                        subtitle: Text(listArticles[index].getPrixEuro()),
                        trailing: TextButton(
                          child: Text("REMOVE"),
                          onPressed: () {
                            context.read<Cart>().remove(listArticles[index]);
                          },
                        )
                    );
                  },
                ),
        ),
        FilledButton(
          onPressed: () => context.go('/cart/payment', extra: intPrixEuro),
          child: const Text("Procéder au paiment")
        )
      ],
    ),
  );
}




class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Votre panier total est de :"),
              Text("0.00€", style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Spacer(),
        Text("Panier Piano Panier Piano Panier Piano Panier Piano"),
        Icon(Icons.piano),
        Spacer(),
      ],
    );
  }
}
