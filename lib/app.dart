

import 'package:epsi_shop/page/about_us_page.dart';
import 'package:epsi_shop/page/cart_page.dart';
import 'package:epsi_shop/page/details_page.dart';
import 'package:epsi_shop/page/home_page.dart';
import 'package:epsi_shop/page/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bo/article.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (_,__) => HomePage(),
      routes:  [
        GoRoute(
            path: "cart",
            builder: (_, __) => CartPage(),
            routes: [
              GoRoute(
                  path: "payment",
                  builder: (BuildContext context, GoRouterState state){
                    if (state.extra is int){
                      return PaymentPage(intPrixEuro: state.extra as int);
                    }
                    else{
                      throw new Exception(true);
                    }
                  }
              )
            ]
        ),
        GoRoute(
            path: "aboutus",
            builder: (_, __) => AboutUsPage()
        ),
        GoRoute(
            path: "details",
            builder: (BuildContext context, GoRouterState state){
              if (state.extra is Article){
                return DetailsPage(article: state.extra as Article);
              }
              else{
                throw new Exception(true);
              }
            }

        )
      ]
    )
  ]
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}