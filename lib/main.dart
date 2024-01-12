import 'package:epsi_shop/bo/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: MyApp(),
    create: (_)=> Cart(),

  ));
}

