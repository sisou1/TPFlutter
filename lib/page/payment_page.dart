import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bo/cart.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, required this.intPrixEuro});

  // Cette variable en int me permet de géré la TVA qui fait *1.20,
  // Je gère le calcule et l'affichage au même endroit même si je sais que c'est pas bien :)
  final int intPrixEuro;


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
                  child: const Icon(Icons.piano)
              )
          ),
          IconButton(
              onPressed: ()=>context.go('/aboutus'),
              icon: const Icon(Icons.info_outline))
        ],
      ),

      //Première Card qui gère les prix
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Bloc récapitulatif
            Recapitulatif(intPrixEuro: intPrixEuro),

            //Bloc Adresse
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Adresse de livraison", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            // Deuxieme card
            const AdresseLivraison(),

            // Bloc Methode de paiment
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Méthode de paiment", style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            const PaymentMethod(),


            const Spacer(),
            const Text("Je suis actuellement a la recherche d'un stage ou d'une alternance pour complété mon année a l'école EPSI, si jamais vous voulez me prendre ou si vous avez des contact apellez le 07 72 43 47 06"),
            const Text("Merci de votre compréhension, Fabien Kiefer"),
            FilledButton(
                onPressed: () {
                  final snackBar = SnackBar(
                    content: const Text('il manque la suite :)'),
                    action: SnackBarAction(
                      label: 'retour',
                      onPressed: () { print("ça fait rien");},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              child: const Text("Confirmer l'achat")
            )

            ],
        ),
      )
    );
  }
}



class Recapitulatif extends StatelessWidget {
  const Recapitulatif({
    super.key,
    required this.intPrixEuro,
  });

  final int intPrixEuro;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
    ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Récapitulatif de votre commande", style: TextStyle(fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sous-Total  "),
                Text("${(intPrixEuro/100)}€")
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Vous économisez", style: TextStyle(color: Colors.green)),
                Text("00.4€", style: TextStyle(color: Colors.green)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("TVA"),
                Text("${(intPrixEuro*0.20).floor()/100}€")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${(intPrixEuro*1.20).floor()/100}€", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdresseLivraison extends StatelessWidget {
  const AdresseLivraison({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Fabien L'Angegardien", style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("44650 rue de broceliande"),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            Row(
              children: [
                Text("22 Corcoué"),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildCard(FontAwesomeIcons.ccApplePay, 0),
        buildCard(FontAwesomeIcons.ccVisa, 1),
        buildCard(FontAwesomeIcons.ccMastercard, 2),
        buildCard(FontAwesomeIcons.ccPaypal, 3),
      ],
    );
  }

  Widget buildCard(IconData iconData, int index) {
    return Badge(
      largeSize: 25,
      label: Icon(Icons.check, size: 16),
      isLabelVisible: selectedIndex == index ? true : false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selectedIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: FaIcon(iconData, size: 48),
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}